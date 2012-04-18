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
  scope :published, where(status: PUBLISHED)

  default_scope order("created_at DESC")

  scope :upcoming_tournaments, tagged_with('tournament').limit(2)

  mount_uploader :featured_image, FeaturedImageUploader

  def to_param
    "#{id}-#{title.parameterize}"
  end

  before_save :expire_sidebar_cache

  def expire_sidebar_cache
    # TODO - do this in a better way
    Rails.cache.delete('views/coaches')
    Rails.cache.delete('views/recent_posts')
    true
  end

  def draft?
    self.status == Post::DRAFT
  end

  def published?
    self.status == Post::PUBLISHED
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
  end

  def threaded_comments
    Comment.threaded_for_post(self.id)
  end

end
