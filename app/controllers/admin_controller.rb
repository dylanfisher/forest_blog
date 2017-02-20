class AdminController < DashboardController
  def index
    super

    additional_resources = []
    @resources = (@resources + additional_resources).sort_by(&:name)
  end
end
