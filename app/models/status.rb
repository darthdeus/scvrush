class Status
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text,        type: String
  field :username,    type: String
  field :user_id,     type: Integer
  field :timeline_id, type: Integer
  field :avatar,      type: String
  field :voters,      type: Array,   default: []
  field :likes_count, type: Integer, default: 0

  validates :text,        presence: true
  validates :user_id,     presence: true
  validates :username,    presence: true
  validates :timeline_id, presence: true
  validates :avatar,      presence: true

  scope :for, lambda { |user| where(timeline_id: user.id).order_by(created_at: :desc) }
  scope :by,  lambda { |user| where(user_id: user.id) }

  def voted?(user)
    self.voters.include?(user.username) if user
  end

  def like(voter)
    if self.voters.include? voter
      false
    else
      self.voters << voter
      self.likes_count += 1
    end
  end

  def unlike(voter)
    if self.voters.include? voter
      self.voters.delete voter
      self.likes_count -= 1
    else
      false
    end
  end

  def self.create_for_signup(user, signup)
    # TODO - need to implement this
  end

  # belongs_to :user

  # belongs_to :statusable, polymorphic: true
  # belongs_to :votable,    polymorphic: true

  # has_many :votes, foreign_key: "voteable_id", conditions: ["votes.voteable_type = 'Status'"]
  # # has_many :votes, source: :voteable

  # attr_accessible :text, :statusable_id, :statusable_type
  # validates :text,    presence: true, length: 1..200
  # validates :user_id, presence: true

  # include ActionView::Helpers

  # # Regenerate the votes count
  # def calculate_votes
  #   self.votes_count = Vote.where(voteable_id: self.id, voteable_type: self.class).count
  #   self.save
  #   self
  # end

  # # # Returns the number of vote votes the given status has
  # # def votes_count
  # #   Vote.where(voteable_id: self.id, voteable_type: self.class).count
  # # end

  # def as_json(options = {})
  #   posted_at = distance_of_time_in_words_to_now(self.created_at, true)
  #   data = {
  #     id: self.id,
  #     text: self.text,
  #     posted_at: posted_at,
  #     user_id: self.user_id,
  #     user_id: self.user.id,
  #     username: self.user.username,
  #     votes_count: self.votes_count,
  #     voted: "0"
  #   }

  #   if options[:user]
  #     voter = VoterDecorator.new(options[:user])
  #     if voter.voted?(self)
  #       data[:voted] = "1"
  #     end
  #   else
  #     data[:voted] = "0"
  #   end

  #   return data
  # end

  # def self.create_for_signup(user, signup)
  #   status = new
  #   status.user = user
  #   status.statusable = signup
  #   tour = TournamentDecorator.new(signup.tournament)
  #   status.text = "Signed up for a tournament #{tour.link_to_self}."
  #   status.save!
  # end

end
