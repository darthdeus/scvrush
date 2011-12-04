class SectionsController < ApplicationController
  def index
    # TODO - check 1+N
    @sections = Section.includes(:topics).order("`order` ASC")
  end

end
