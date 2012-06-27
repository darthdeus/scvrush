module Admin
  class TournamentsController < AdminController
    def index
      @tournaments = Tournament.all
    end

    def new
      @tournament = Tournament.new
    end

    def create
      @tournament = Tournament.new(params[:tournament])
      if @tournament.save
        flash[:success] = "Tournament was successfuly added."
        redirect_to tournaments_path
      else
        render :new
      end
    end

    def edit
      @tournament = Tournament.find(params[:id])
    end

    def update
      @tournament = Tournament.find(params[:id])
      if @tournament.update_attributes(:params[:tournament])
        flash[:success] = "Tournament was updated."
        redirect_to tournaments_path
      else
        render :edit
      end
    end


  end
end
