class Status < ActiveRecord::Base
  belongs_to :user

  belongs_to :statusable, polymorphic: true
  belongs_to :votable,    polymorphic: true

  has_many :votes, foreign_key: "voteable_id", conditions: ["votes.voteable_type = 'Status'"]
  # has_many :votes, source: :voteable

  attr_accessible :text, :statusable_id, :statusable_type
  validates :text,    presence: true, length: 6..200
  validates :user_id, presence: true

  include ActionView::Helpers

  # Regenerate the votes count
  def calculate_votes
    self.votes_count = Vote.where(voteable_id: self.id, voteable_type: self.class).count
    self.save
    self
  end

  # # Returns the number of vote votes the given status has
  # def votes_count
  #   Vote.where(voteable_id: self.id, voteable_type: self.class).count
  # end

  def as_json(options = {})
    posted_at = distance_of_time_in_words_to_now(self.created_at, true)
    data = {
      id: self.id,
      text: self.text,
      posted_at: posted_at,
      user_id: self.user_id,
      user_id: self.user.id,
      username: self.user.username,
      votes_count: self.votes_count,
      voted: "0"
    }

    if options[:user]
      voter = VoterDecorator.new(options[:user])
      if voter.voted?(self)
        data[:voted] = "1"
      end
    else
      data[:voted] = self.voted
    end

    return data
  end

  def self.create_for_signup(user, signup)
    status = new
    status.user = user
    status.statusable = signup
    tour = TournamentDecorator.new(signup.tournament)
    status.text =<<STATUS
Signed up for a tournament #{tour.link_to_self}.
STATUS
    status.save!
  end

end
