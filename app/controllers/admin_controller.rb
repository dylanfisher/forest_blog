class AdminController < DashboardController
  def index
    super

    additional_resources = %w(Artist Artwork Exhibition).collect(&:safe_constantize).reject(&:blank?)
    @resources = (@resources + additional_resources).sort_by(&:name)
  end
end
