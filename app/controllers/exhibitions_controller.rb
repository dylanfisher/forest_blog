class ExhibitionsController < ForestController
  include BlockableControllerConcerns
  include FilterControllerScopes

  layout 'admin', except: [:show]

  before_action :set_exhibition, only: [:show, :edit, :update, :destroy, :versions, :version, :restore]
  # before_action :set_paper_trail_whodunnit

  has_scope :by_status

  def index
    @exhibitions = apply_scopes(Exhibition).by_id.page params[:page]
    authorize @exhibitions
  end

  def versions
    authorize @exhibition
    @versions = @exhibition.versions
    status = params[:by_status] && Exhibition.statuses[params[:by_status]]
    if status
      @versions = @versions.where_object(status: status)
    end
    @versions = @versions.reorder(created_at: :desc, id: :desc).page params[:page]
  end

  def restore
    authorize @exhibition
    @version = @exhibition.versions.find(params['version_id'])
    @exhibition = @version.reify
    @exhibition.reify_page_slots!

    respond_to do |format|
      if @exhibition.save
        format.html { redirect_to exhibition_versions_path(@exhibition), notice: 'Exhibition version was successfully restored.' }
        format.json { render :show, status: :ok, location: @exhibition }
      else
        format.html { render :versions }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize @exhibition
  end

  def version
    authorize @exhibition
    @version = @exhibition.versions.find(params['version_id'])
    @exhibition = @version.reify
    # TODO: some way to reify blocks for other versions
    render :show
  end

  def new
    @exhibition = Exhibition.new
    authorize @exhibition
    set_block_record
  end

  def edit
    authorize @exhibition
    set_block_record
  end

  def create
    @exhibition = Exhibition.new
    authorize @exhibition

    # TODO: Handle block type deletion
    parse_block_attributes @exhibition, record_type: 'exhibition'

    @exhibition.assign_attributes exhibition_params

    respond_to do |format|
      if @exhibition.valid?
        save_page @exhibition
        format.html { redirect_to edit_exhibition_path(@exhibition), notice: 'Exhibition was successfully created.' }
        format.json { render :show, status: :created, location: @exhibition }
      else
        format.html { render :new }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @exhibition

    # TODO: Handle block type deletion
    parse_block_attributes @exhibition, record_type: 'exhibition'

    @exhibition.assign_attributes exhibition_params

    respond_to do |format|
      if @exhibition.valid?
        save_page @exhibition
        format.html { redirect_to edit_exhibition_path(@exhibition), notice: 'Exhibition was successfully updated.' }
        format.json { render :show, status: :ok, location: @exhibition }
      else
        format.html { render :edit }
        format.json { render json: @exhibition.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @exhibition
    @exhibition.destroy
    respond_to do |format|
      format.html { redirect_to exhibitions_url, notice: 'Exhibition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def exhibition_params
      params.require(:exhibition).permit(:title, :slug, :title, :description, :start_date, :end_date, :status, artist_ids: [], artwork_ids: [],
        page_slots_attributes: [:id, :_destroy, :block_id, :block_type, :block_previous_version_id, :position, :block_record_type, :block_record_id, *BlockType.block_type_params])
    end

    def set_exhibition
      if action_name == 'show'
        # TODO: Published scope
        @exhibition = Exhibition.friendly.find(params[:id]) # Don't eager load associations when cached in show
      else
        @exhibition = Exhibition.includes(page_slots: :block).friendly.find(params[:id])
      end

      @record = @exhibition

      # TODO: update page title as necessary
      @page_title = @exhibition.try(:title)
    rescue ActiveRecord::RecordNotFound
      if action_name == 'show' && Rails.env.production?
        redirect_to root_url, flash: { error: 'Record not found.' }
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def set_block_record
      @block_record = @exhibition.block_record || @exhibition.build_block_record
    end

end
