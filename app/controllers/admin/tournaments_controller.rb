module Admin
  class TournamentsController < AdminController

    def index
      respond_to do |format|
        format.html

        format.json do
          fields  = %w[name]
          columns = %w[name starts_at]
          table   = Datable.new(Tournament, fields, columns, params) do |tournament|
            tournament = TournamentDecorator.new(tournament)

            [
              tournament.name,
              tournament.starts_at.to_s,
              tournament.action_buttons
            ]
          end

          render json: table
        end
      end
      @tournaments = Tournament.all
    end

    def new
      @tournament = Tournament.new
    end

    def create
      @tournament = Tournament.new(params[:tournament])
      if @tournament.save
        flash[:success] = "Tournament was created."
        bracket = Bracket.new(@tournament)

        redirect_to @tournament
      else
        render :new
      end
    end

    def edit
      @tournament = Tournament.find(params[:id])
    end

    def update
      @tournament = Tournament.find(params[:id])
      if @tournament.update_attributes(params[:tournament])
        flash[:success] = "Tournament was updated."
        redirect_to admin_tournaments_path
      else
        render :edit
      end
    end

    def destroy
      Tournament.find(params[:id]).destroy
      flash[:success] = "Tournament was deleted."
      redirect_to admin_tournaments_path
    end

  end
end
