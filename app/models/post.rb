class Post < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_one :tournament

  validates :title, :presence => true
  validates :content, :presence => true

  acts_as_taggable

  scope :drafts, where(:status => DRAFT)
  scope :published, where(:status => PUBLISHED)
  default_scope order("created_at DESC")

  scope :upcoming_tournaments, tagged_with('tournament').limit(2)

  mount_uploader :featured_image, FeaturedImageUploader

  def to_param
    "#{id}-#{title.parameterize}"
  end
end
