class BlogPost < ActiveRecord::Base
  scope :recent, order('`order` DESC').limit(5)
end
