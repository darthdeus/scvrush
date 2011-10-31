class Article < ActiveRecord::Base
  belongs_to :category
  
  validates :title, :presence => true, :uniqueness => true
  validates :text, :presence => true
  validates :category, :presence => true
end
