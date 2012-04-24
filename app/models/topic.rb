class Topic < ActiveRecord::Base
  # add test for mass assignment check
  # TODO - figure out how to work around the user_id thing
  attr_accessible :section, :name, :section_id, :user_id

  belongs_to :section
  belongs_to :user
  has_many :replies

  belongs_to :last_reply, class_name: 'Reply', foreign_key: 'last_reply_id'

  validates :user, presence: true
  validates :section, presence: true
  validates :name, presence: true

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def to_simple_json
    {
      name: self.name,
      last_reply_at: time_ago_in_words(self.last_reply_at)
    }
  end

end
