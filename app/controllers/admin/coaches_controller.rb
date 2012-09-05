module Admin
  class CoachesController < AdminController

    skip_filter :require_admin, only: :index

    def index
      respond_to do |format|
        @coaches = Coach.all

        format.html
        format.json { render json: @coaches.sample(6) }
      end
    end

    def new
      @coach = Coach.new
    end

    def create
      @coach = Coach.new(params[:coach])
      if @coach.save
        flash[:success] = "Coach was successfuly added."
        redirect_to admin_coaches_path
      else
        render :new
      end
    end

    def edit
      @coach = Coach.find(params[:id])
    end

    def update
      @coach = Coach.find(params[:id])
      if @coach.update_attributes(params[:coach])
        flash[:success] = "Coach was successfuly updated."
        redirect_to admin_coaches_path
      else
        render :edit
      end
    end

    def destroy
      Coach.find(params[:id]).destroy
      flash[:success] = "Coach was deleted"
      redirect_to admin_coaches_path
    end

  end
end
