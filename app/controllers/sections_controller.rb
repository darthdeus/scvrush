class SectionsController < ApplicationController
  def index
    @sections = Section.order("`order` DESC")
  end

end
