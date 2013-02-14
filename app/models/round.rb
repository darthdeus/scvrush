class Round < ActiveRecord::Base
  attr_accessible :number, :tournament, :bo, :text, :parent, :child

  validates_presence_of :number, :tournament

  belongs_to :tournament

  belongs_to :parent, class_name: "Round", foreign_key: "parent_id"
  has_one    :child, class_name: "Round", foreign_key: "parent_id"
  has_many   :matches, dependent: :destroy, order: "id"

  def next
    parent
  end

  def next?
    !!self.next
  end

  # Return a match with given seed
  def match_with_seed(seed)
    self.matches.order(:id).where(seed: seed).first
  end

  def is_first?
    self.tournament.rounds.first == self
  end

end
