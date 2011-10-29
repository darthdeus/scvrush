class Article < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title
  validates_presence_of :text
  validates_presence_of :category

  validates_uniqueness_of :title
end
