class BattleReportsController < AuthenticatedController
  def index
    @battle_reports = BattleReportsIndex.new
  end

  def show
    @battle_report = BattleReport.find(params[:id])
  end
end
