class SectionsController < ApplicationController
  def index
    # fix 1+N here
    @sections = Section.order("`order` ASC")
  end

end
