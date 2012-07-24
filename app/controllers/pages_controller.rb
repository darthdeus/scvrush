class PagesController < ApplicationController
  def show
    if params[:id] == "staff"
      page = Page.find_or_create_by_name("staff")
      gon.categories = page.content
      render "staff"
    else
      render params[:id]
    end
  end

end
