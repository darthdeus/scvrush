class Topic < ActiveRecord::Base
  # add test for mass assignment check
  attr_accessible :section, :name, :section_id

  belongs_to :section
  belongs_to :user
  has_many :replies
  belongs_to :last_reply, :class_name => 'Reply', :foreign_key => 'last_reply_id'

  validates :user, :presence => true
  validates :section, :presence => true
  validates :name, :presence => true

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
