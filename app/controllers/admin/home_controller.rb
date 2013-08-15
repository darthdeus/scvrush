module Admin
  class HomeController < AdminController
    def index
      @kpi = Kpi.new
    end
  end
end
