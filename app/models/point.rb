class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :reason, polymorphic: true

  validates_presence_of :user
end
