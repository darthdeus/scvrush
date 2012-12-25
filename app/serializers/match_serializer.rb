class MatchSerializer < ActiveModel::Serializer
  attributes :id, :player1, :player2, :player1_score, :player2_score, :number, :completed

  def player1
    object.player1.bnet_info
  end

  def player2
    object.player2.bnet_info
  end

  def player1_score
    object.score_for(:player1)
  end

  def player2_score
    object.score_for(:player2)
  end
end
