class Point < ActiveRecord::Base
  belongs_to :user
  
  blongs_to :reason, :polymorphic => true
  
end
