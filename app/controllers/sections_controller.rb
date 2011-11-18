class SectionsController < ApplicationController
  def index
    @sections = Section.all(:include => :topics).order("order DESC")
  end

end
