class Post < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2

  attr_accessible :title, :content, :featured_image, :status,
                  :user, :user_id, :comments_enabled, :tag_list, :published_at

  belongs_to :user
  has_one :tournament
  has_one :coach

  validates :title, presence: true
  validates :content, presence: true

  acts_as_taggable

  scope :drafts, -> { where(status: DRAFT) }
  scope :published, -> { where("status = ? AND published_at IS NOT NULL", PUBLISHED) }

  default_scope -> { order("published_at DESC, id DESC") }

  scope :upcoming_tournaments, -> { tagged_with('tournament').limit(2) }

  mount_uploader :featured_image, FeaturedImageUploader

  def tag_names
    tag_list.join " "
  end

  def author_name
    user ? user.username : ""
  end

  def author_avatar_thumb
    user.avatar.url(:thumb)
  end

  def about_author
    user.about
  end

  def readable_published_at
    self.published_at.strftime("#{self.published_at.day.ordinalize} %b %Y")
  end

end
