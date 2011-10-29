class Article < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title
  validates_presence_of :text
  
end
