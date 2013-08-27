class BattleReportsController < AuthenticatedController
  def index
    @battle_reports = BattleReport.all
  end

  def show
    @battle_report = BattleReport.find(params[:id])
  end
end
