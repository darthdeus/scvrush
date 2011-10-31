class Category < ActiveRecord::Base
  has_many :articles

  validates :name, :presence => true, :uniqueness => true
end
