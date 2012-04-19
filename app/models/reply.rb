class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :topic, presence: true
  validates :user, presence: true
  validates :content, presence: true

  after_create :set_last_reply

  acts_as_voteable

  def set_last_reply
    self.topic.last_reply = self
    self.topic.last_reply_at = self.created_at
    self.topic.save!
  end
end
