class SectionsController < ApplicationController

  def index
    # TODO - check 1+N
    respond_to do |format|
      format.html do
        @sections = Section.includes(:topics).order('"order" ASC')
      end
      format.json { render json: Section.order('"order" ASC') }
    end
  end

end
