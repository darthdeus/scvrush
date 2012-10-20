class RoundCreator

  def default_maps(index)
    if index == 0
      return <<MAPS
MLG Entombed Valley
GSL Metropolis
ESV Ohana LE
MAPS
    elsif index == 1
      return <<MAPS
GSL Bel'Shir Beach (Winter)
ESL Cloud Kingdom
GSL Daybreak
MAPS
    end
  end

  def default_bo(round_number)
    [1,2,4].include?(round_number) ? 3 : 1
  end

  def create(tournament, round_number, parent, index)
    round      = Round.new(number: round_number, tournament: tournament, parent: parent)
    round.bo   = default_bo(round_number)
    round.text = default_maps(index)

    # TODO - set the BO preset if there is one for given rounds
    if tournament.bo_preset
      bo_preset = tournament.bo_preset.split(" ").map(&:to_i)
      round.bo = bo_preset[index] if bo_preset[index]
    end

    if tournament.maps.present?
      round.text = tournament.maps[index] if tournament.maps[index]
    end

    round
  end

end
