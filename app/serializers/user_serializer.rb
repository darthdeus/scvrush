class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info, :followers, :following

  # TODO - this should be the timeline statuses, not the authored ones
  has_many :statuses, embed: :ids

  def followers
    object.followers.map(&:username)
  end

  def following
    object.following.map(&:username)
  end

  # has_many :followers, embed: :ids
  # has_many :following, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
