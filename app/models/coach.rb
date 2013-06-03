class Coach < ActiveRecord::Base
  attr_accessible :name, :about, :races, :servers, :languages
  validates_presence_of :name, :about, :races, :servers, :languages
end
