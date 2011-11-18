class Topic < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :replies

  validates :user, :presence => true
  validates :section, :presence => true
  validates :name, :presence => true
end
