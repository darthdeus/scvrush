class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates :topic, :presence => true
  validates :user, :presence => true
  validates :content, :presence => true

  after_create :set_last_reply

  def set_last_reply
    self.topic.last_reply = self
    self.topic.save!
  end
end
