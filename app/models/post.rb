class Post < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2

  attr_accessible :title, :content, :featured_image, :status,
                  :user, :user_id, :comments_enabled, :tag_list

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

  include Tire::Model::Search
  include Tire::Model::Callbacks
  mapping do
    indexes :id,          index: :not_analyzed
    indexes :title,       analyzer: "snowball", boost: 100
    indexes :content,     analyzer: "snowball"
    indexes :tag_names,   analyzer: "snowball", boost: 200
    indexes :author_name, analyzer: "snowball", boost: 50
  end

  def to_indexed_json
    to_json(only: [:title, :content], methods: [:tag_names, :author_name])
  end

  def self.race_post(race)
    tags = %w(coach terran zerg protoss)
    published.tagged_with(race).tagged_with(tags - [race], exclude: true).first
  end

  def author_name
    user && user.username
  end

  def tag_names
    tag_list.join " "
  end

  def draft?
    status == Post::DRAFT
  end

  def published?
    status == Post::PUBLISHED
  end

  def author_avatar_thumb
    self.user.avatar.url(:thumb)
  end

  def readable_published_at
    self.published_at.strftime("#{self.published_at.day.ordinalize} %b %Y")
  end

end
