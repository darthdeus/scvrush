class Reply < ActiveRecord::Base
  # TODO - add attr_accessible with specs

  belongs_to :topic
  belongs_to :user

  validates :topic, presence: true
  validates :user, presence: true
  validates :content, presence: true

  after_create :set_last_reply

  include ActionView::Helpers

  def self.for_topic(topic_id)
    where(topic_id: topic_id).includes(:user).map(&:to_simple_json)
  end

  def to_simple_json
    {
      id:      self.id,
      content: simple_format(self.content),
      user_id: self.user.id,
      author:  self.user.username,
      date:    time_ago_in_words(self.created_at)
    }
  end

  def set_last_reply
    self.topic.last_reply = self
    self.topic.last_reply_at = self.created_at
    self.topic.save!
  end
end
