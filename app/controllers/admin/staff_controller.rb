module Admin
  class StaffController < AdminController

    def index
      page = Page.find_or_create_by_name("staff")
      if params[:staff]
        page.content = params[:staff]
        page.save!
      end
      @data = page.content
    end

  end
end
