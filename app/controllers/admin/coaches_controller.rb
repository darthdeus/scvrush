module Admin
  class CoachesController < AdminController
    def index
      @coaches = Coach.all
    end

    def new
      @coach = Coach.new
    end

    def create
      @coach = Coach.new(params[:coach])
      if @coach.save
        flash[:success] = "Coach was successfuly added."
        redirect_to coaches_path
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
        redirect_to coaches_path
      else
        render :edit
      end
    end

  end
end
