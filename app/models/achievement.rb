class Achievement < ActiveRecord::Base
  has_many :user_achievements, dependent: :destroy
  has_many :users, through: :user_achievements

  before_save :set_slug

  # TODO - is description really necessary?
  validates_presence_of :name#, :description

  private

  def set_slug
    self.slug = self.name.parameterize
  end

end
