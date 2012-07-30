class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :statusable, polymorphic: true

  attr_accessible :text, :statusable_id, :statusable_type
  validates_presence_of :user_id
  validates :text, presence: true, length: 6..200

  has_reputation :votes, source: :user, aggregated_by: :sum

  include ActionView::Helpers

  def as_json(options = {})
    posted_at = distance_of_time_in_words_to_now(self.created_at, true)
    data = {
      id: self.id,
      text: self.text,
      posted_at: posted_at,
      user_id: self.user_id,
      votes_count: self.votes,
      user_id: self.user.id,
      username: self.user.username,
      voted: false
    }

    # TODO - check this
    if options[:user] && options[:user].respond_to?(:voted_for?)
      data[:voted] = options[:user].voted_for?(self)
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
