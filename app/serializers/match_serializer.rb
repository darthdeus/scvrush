class MatchSerializer < ActiveModel::Serializer
  attributes :id, :player1_score, :player2_score, :completed, :score, :round_id

  has_one :player1, embed: :ids
  has_one :player2, embed: :ids

  def player1_score
    object.score_for(:player1)
  end

  def player2_score
    object.score_for(:player2)
  end
end
