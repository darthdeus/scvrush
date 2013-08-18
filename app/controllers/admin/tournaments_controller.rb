module Admin
  class TournamentsController < AdminController

    def index
      respond_to do |format|
        format.html

        format.json do
          fields  = %w[name]
          columns = %w[name starts_at]
          table   = Datable.new(Tournament, fields, columns, params) do |tournament|
            [
              "<a href='/#/tournaments/#{tournament.id}' target='_blank'>#{tournament.name}</a>",
              tournament.starts_at.to_s,
              "<a href='/admin/tournaments/#{tournament.id}/edit' target='_blank'>edit</a>&nbsp;" +
              view_context.link_to("delete", "/admin/tournaments/#{tournament.id}", method: :delete, confirm: "Are you sure?" )
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
      @tournament.user = current_user

      if @tournament.save
        flash[:notice] = "Tournament was created."
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
        flash[:notice] = "Tournament was updated."
        redirect_to @tournament
      else
        render :edit
      end
    end

    def destroy
      Tournament.find(params[:id]).destroy
      flash[:notice] = "Tournament was deleted."
      redirect_to admin_tournaments_path
    end

  end
end
