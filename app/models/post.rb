class Post < ActiveRecord::Base
  DRAFT = 0
  PUBLISHED = 1
  DELETED = 2

  attr_accessible :title, :content, :featured_image, :status,
                  :user, :user_id, :comments_enabled, :tag_list

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :tournament
  has_one :coach

  validates :title, presence: true
  validates :content, presence: true

  acts_as_taggable

  scope :drafts,    where(status: DRAFT)
  scope :published, where("status = ? AND published_at IS NOT NULL", PUBLISHED)

  default_scope order("published_at DESC, id DESC")

  scope :upcoming_tournaments, tagged_with('tournament').limit(2)

  mount_uploader :featured_image, FeaturedImageUploader

  def to_param
    "#{id}-#{title.parameterize}"
  end

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :id,          index: :not_analyzed
    indexes :title,       analyzer: "snowball", boost: 100
    indexes :content,     analyzer: "snowball"
    indexes :tag_names,   analyzer: "snowball", boost: 50
    indexes :author_name, analyzer: "snowball", boost: 50
  end

  def author_name
    user && user.username
  end

  def tag_names
    tag_list.join " "
  end

  def to_indexed_json
    to_json(only: [:title, :content], methods: [:tag_names, :author_name])
  end

  def self.race_post(race)
    tags = %w(coach terran zerg protoss)
    published.tagged_with(race).tagged_with(tags - [race], exclude: true).first
  end

  def self.related(post)
    tagged_with(post.tag_list, any: true).limit(3)
  end

  def self.news_posts(tag)
    published.tagged_with(tag).page(0).limit(6)
  end

  def draft?
    self.status == Post::DRAFT
  end

  def published?
    self.status == Post::PUBLISHED
  end

  def author_avatar_thumb
    self.user.avatar.url(:thumb)
  end

  def readable_published_at
    self.published_at.strftime("#{self.published_at.day.ordinalize} %b %Y")
  end

  # Set a post publish status & published_at date for given parameters
  #
  # params - A hash of params. To unpublish, set :published == "0",
  #          otherwise you have to provide both :date and :time when
  #          specifying :published == "1". Any other :published value
  #          will raise an exception.
  def publish(params)
    if params[:published] == "1"
      self.status = Post::PUBLISHED
      begin
        raise ArgumentError.new if !(params.has_key?(:date) && params.has_key?(:time))
        self.published_at = Time.parse("#{params[:date]} #{params[:time]}")
      rescue ArgumentError
        raise ArgumentError.new("Invalid date or time format")
      end
    elsif params[:published] == "0"
      self.status = Post::DRAFT
    else
      raise ArgumentError.new("Invalid published status '#{params[:published].inspect}'")
    end
    self
  end

  def threaded_comments
    Comment.threaded_for_post(self.id)
  end

end
