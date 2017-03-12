class ArtistsController < ForestController
  include BlockableControllerConcerns
  include FilterControllerScopes

  layout 'admin', except: [:show]

  before_action :set_artist, only: [:show, :edit, :update, :destroy, :versions, :version, :restore]
  # before_action :set_paper_trail_whodunnit

  has_scope :by_status
  has_scope :name_or_id_like

  def index
    @artists = apply_scopes(Artist).by_name.page params[:page]
  end

  def versions
    authorize @artist
    @versions = @artist.versions
    status = params[:by_status] && Artist.statuses[params[:by_status]]
    if status
      @versions = @versions.where_object(status: status)
    end
    @versions = @versions.reorder(created_at: :desc, id: :desc).page params[:page]
  end

  def restore
    authorize @artist
    @version = @artist.versions.find(params['version_id'])
    @artist = @version.reify
    @artist.reify_page_slots!

    respond_to do |format|
      if @artist.save
        format.html { redirect_to artist_versions_path(@artist), notice: 'Artist version was successfully restored.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :versions }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @artist
  end

  def version
    authorize @artist
    @version = @artist.versions.find(params['version_id'])
    @artist = @version.reify
    # TODO: some way to reify blocks for other versions
    render :show
  end

  def new
    @artist = Artist.new
    authorize @artist
    set_block_record
  end

  def edit
    authorize @artist
    set_block_record
  end

  def create
    @artist = Artist.new
    authorize @artist

    # TODO: Handle block type deletion
    parse_block_attributes @artist, record_type: 'artist'

    @artist.assign_attributes artist_params

    respond_to do |format|
      if @artist.valid?
        save_page @artist
        format.html { redirect_to edit_artist_path(@artist), notice: 'Artist was successfully created.' }
        format.json { render :show, status: :created, location: @artist }
      else
        format.html { render :new }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @artist

    # TODO: Handle block type deletion
    parse_block_attributes @artist, record_type: 'artist'

    @artist.assign_attributes artist_params

    respond_to do |format|
      if @artist.valid?
        save_page @artist
        format.html { redirect_to edit_artist_path(@artist), notice: 'Artist was successfully updated.' }
        format.json { render :show, status: :ok, location: @artist }
      else
        format.html { render :edit }
        format.json { render json: @artist.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @artist
    @artist.destroy
    respond_to do |format|
      format.html { redirect_to artists_url, notice: 'Artist was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def artist_params
      params.require(:artist).permit(:title, :slug, :first_name, :last_name, :bio, :status, exhibition_ids: [], artwork_ids: [],
        page_slots_attributes: [:id, :_destroy, :block_id, :block_type, :block_previous_version_id, :position, :block_record_type, :block_record_id, *BlockType.block_type_params])
    end

    def set_artist
      if action_name == 'show'
        # TODO: Published scope
        @artist = Artist.find_by_slug(params[:id]) # Don't eager load associations when cached in show
      else
        @artist = Artist.includes(page_slots: :block).find_by_slug(params[:id])
      end

      @record = @artist

      # TODO: update page title as necessary
      @page_title = @artist.try(:title)
    rescue ActiveRecord::RecordNotFound
      if action_name == 'show' && Rails.env.production?
        redirect_to root_url, flash: { error: 'Record not found.' }
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def set_block_record
      @block_record = @artist.block_record || @artist.build_block_record
    end

end
