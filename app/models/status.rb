class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :statusable, polymorphic: true

  attr_accessible :text, :statusable_id, :statusable_type
  validates_presence_of :text, :user_id

  include ActionView::Helpers

  def as_json(options = {})
    posted_at = distance_of_time_in_words_to_now(self.created_at, true)
    {
      id: self.id,
      text: self.text,
      posted_at: posted_at,
      user_id: self.user_id
    }
  end
end
