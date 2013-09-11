class BattleReportsIndex
  def eu
    all.where(tournaments: { region: "EU" })
  end

  def na
    all.where(tournaments: { region: "NA" })
  end

  private

  def all
    BattleReport.includes(:tournament)
  end
end
