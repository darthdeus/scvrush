class Status < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :text, :user
  attr_accessible :text, :user_id, :user

  # default_scope order("created_at ASC")
end
