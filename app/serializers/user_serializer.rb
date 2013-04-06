class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :race, :image, :bnet_info, :expires_at,
             :server, :about, :league, :follower_ids, :followee_ids

  has_many :tournaments, embed: :ids, include: true
  has_many :statuses, embed: :ids
  has_many :notifications, embed: :ids

  def include_tournaments?
    scope.id == object.id if scope
  end

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
