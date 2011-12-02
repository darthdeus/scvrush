class SectionsController < ApplicationController
  def index
    # TODO - check 1+N
    @sections = Section.include(:topics).order("`order` ASC")
  end

end
