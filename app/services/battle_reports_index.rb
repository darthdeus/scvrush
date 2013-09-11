class BattleReportsIndex
  attr_reader :filter

  def initialize(filter = nil)
    @filter = filter
  end

  def eu
    results = all.where(tournaments: { region: "EU" })
  end

  def na
    all.where(tournaments: { region: "NA" })
  end

  private

  def all
    results = BattleReport.includes(:tournament)
    results = results.where(tournaments: { tournament_type: filter }) if filter
    results
  end
end
