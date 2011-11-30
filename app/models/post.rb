class Post < ActiveRecord::Base  
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2
  
  has_many :comments, :dependent => :destroy
    
  validates :title, :presence => true #, :uniqueness => true
  validates :content, :presence => true
  
  acts_as_taggable

  scope :drafts, where(:status => DRAFT)
  scope :published, where(:status => PUBLISHED)  
  default_scope order("created_at DESC")

  mount_uploader :featured_image, FeaturedImageUploader
  
  def to_param
    "#{id}-#{title.parameterize}"
  end
end
