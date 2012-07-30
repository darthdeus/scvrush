class Vote < ActiveRecord::Base

  # scope :for_voter, lambda { |*args| where(["voter_id = ? AND voter_type = ?", args.first.id, args.first.class.name]) }
  # scope :for_voteable, lambda { |*args| where(["voteable_id = ? AND voteable_type = ?", args.first.id, args.first.class.name]) }
  # scope :recent, lambda { |*args| where(["created_at > ?", (args.first || 2.weeks.ago)]) }
  # scope :descending, order("created_at DESC")

  belongs_to :voteable, polymorphic: true
  belongs_to :user

  attr_accessible :value, :user, :voteable

  validates_presence_of :value, :user, :voteable

  # Comment out the line below to allow multiple votes per user.
  # validates_uniqueness_of :voteable_id, scope: [:voteable_type, :user_id]

end
