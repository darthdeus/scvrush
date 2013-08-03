class Coach < ActiveRecord::Base
  attr_accessible :name, :about, :races, :servers, :languages
  validates_presence_of :name, :about, :races, :servers, :languages

  def main_server_icon
    "coaches_#{servers.first}.png"
  end

  def race_icons
    races.map { |race| "race_#{race}_icon.png" }
  end

end
