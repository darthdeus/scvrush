class Admin::BattleReportsController < Admin::AdminController
    skip_filter :require_login, only: :index
    skip_filter :require_admin, only: :index

    def index
      respond_to do |format|
        @battle_reports = BattleReport.scoped

        format.html do
          require_admin
        end
        format.json { render json: @battle_reports.sample(6).as_json(include_root: false) }
      end
    end

    def new
      @battle_report = BattleReport.new
    end

    def create
      @battle_report = BattleReport.new(params[:battle_report])
      if @battle_report.save
        flash[:success] = "BattleReport was successfuly added."
        redirect_to admin_battle_reports_path
      else
        render :new
      end
    end

    def edit
      @battle_report = BattleReport.find(params[:id])
    end

    def update
      @battle_report = BattleReport.find(params[:id])
      if @battle_report.update_attributes(params[:battle_report])
        flash[:success] = "BattleReport was successfuly updated."
        redirect_to admin_battle_reports_path
      else
        render :edit
      end
    end

    def destroy
      Admin.find(params[:id]).destroy
      flash[:success] = "BattleReport was deleted"
      redirect_to admin_battle_reports_path
    end

  end
