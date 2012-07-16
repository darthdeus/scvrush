class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :statusable, polymorphic: true

  attr_accessible :text, :statusable_id, :statusable_type

  validates_presence_of :text, :user_id
end
