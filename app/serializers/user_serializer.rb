class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :race, :image, :bnet_info, :about, :server, :expires_at,
              :follower_ids, :following_ids

  has_many :tournaments, embed: :ids, include: true
  has_many :statuses, embed: :ids

  def include_tournaments?
    scope.id == object.id if scope
  end

  def status_ids
    Timeline.for_user(object).map(&:id)
  end

  def follower_ids
    object.followers.map(&:id)
  end

  def following_ids
    object.following.map(&:id)
  end

  # has_many :followers, embed: :ids
  # has_many :following, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
