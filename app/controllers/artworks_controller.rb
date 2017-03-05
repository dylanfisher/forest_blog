class ArtworksController < ForestController
  include BlockableControllerConcerns
  include FilterControllerScopes

  layout 'admin', except: [:show]

  before_action :set_artwork, only: [:show, :edit, :update, :destroy, :versions, :version, :restore]
  # before_action :set_paper_trail_whodunnit

  has_scope :by_status
  has_scope :title_like

  def index
    @artworks = apply_scopes(Artwork).by_id.page params[:page]
    authorize @artworks
  end

  def versions
    authorize @artwork
    @versions = @artwork.versions
    status = params[:by_status] && Artwork.statuses[params[:by_status]]
    if status
      @versions = @versions.where_object(status: status)
    end
    @versions = @versions.reorder(created_at: :desc, id: :desc).page params[:page]
  end

  def restore
    authorize @artwork
    @version = @artwork.versions.find(params['version_id'])
    @artwork = @version.reify
    @artwork.reify_page_slots!

    respond_to do |format|
      if @artwork.save
        format.html { redirect_to artwork_versions_path(@artwork), notice: 'Artwork version was successfully restored.' }
        format.json { render :show, status: :ok, location: @artwork }
      else
        format.html { render :versions }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @artwork
  end

  def version
    authorize @artwork
    @version = @artwork.versions.find(params['version_id'])
    @artwork = @version.reify
    # TODO: some way to reify blocks for other versions
    render :show
  end

  def new
    @artwork = Artwork.new
    authorize @artwork
    set_block_record
  end

  def edit
    authorize @artwork
    set_block_record
  end

  def create
    @artwork = Artwork.new
    authorize @artwork

    # TODO: Handle block type deletion
    parse_block_attributes @artwork, record_type: 'artwork'

    @artwork.assign_attributes artwork_params

    respond_to do |format|
      if @artwork.valid?
        save_page @artwork
        format.html { redirect_to edit_artwork_path(@artwork), notice: 'Artwork was successfully created.' }
        format.json { render :show, status: :created, location: @artwork }
      else
        format.html { render :new }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @artwork

    # TODO: Handle block type deletion
    parse_block_attributes @artwork, record_type: 'artwork'

    @artwork.assign_attributes artwork_params

    respond_to do |format|
      if @artwork.valid?
        save_page @artwork
        format.html { redirect_to edit_artwork_path(@artwork), notice: 'Artwork was successfully updated.' }
        format.json { render :show, status: :ok, location: @artwork }
      else
        format.html { render :edit }
        format.json { render json: @artwork.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @artwork
    @artwork.destroy
    respond_to do |format|
      format.html { redirect_to artworks_url, notice: 'Artwork was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def artwork_params
      params.require(:artwork).permit(:title, :slug, :title, :description, :date, :status, :featured_image_id, artist_ids: [], exhibition_ids: [],
        page_slots_attributes: [:id, :_destroy, :block_id, :block_type, :block_previous_version_id, :position, :block_record_type, :block_record_id, *BlockType.block_type_params])
    end

    def set_artwork
      if action_name == 'show'
        # TODO: Published scope
        @artwork = Artwork.friendly.find(params[:id]) # Don't eager load associations when cached in show
      else
        @artwork = Artwork.includes(page_slots: :block).friendly.find(params[:id])
      end

      @record = @artwork

      # TODO: update page title as necessary
      @page_title = @artwork.try(:title)
    rescue ActiveRecord::RecordNotFound
      if action_name == 'show' && Rails.env.production?
        redirect_to root_url, flash: { error: 'Record not found.' }
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def set_block_record
      @block_record = @artwork.block_record || @artwork.build_block_record
    end

end
