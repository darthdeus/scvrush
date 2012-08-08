class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notifiable, polymorphic: true
  attr_accessible :text, :unread, :notifiable

  validates_presence_of :user, :notifiable, :text, :unread
end
