class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :race, :image, :bnet_info, :expires_at,
             :server, :about, :league, :follower_ids, :followee_ids, :achievement_ids, :is_trial

  has_many :tournaments, embed: :ids, include: true
  has_many :statuses, embed: :ids
  has_many :notifications, embed: :ids

  def is_trial
    !!object.expires_at
  end

  def achievement_ids
    Tournament.where(winner_id: object.id).pluck(:id)
    Tournament.limit(6).pluck(:id)
  end

  def followee_ids
    ids = object.followee_ids_cache
    ids ? ids.split(" ").map(&:to_i) : []
  end

  def follower_ids
    ids = object.follower_ids_cache
    ids ? ids.split(" ").map(&:to_i) : []
  end

  def include_tournaments?
    scope.id == object.id if scope
  end

  def image
    object.avatar.url(:thumb)
    "/assets/default_avatar.png"
  end

end
