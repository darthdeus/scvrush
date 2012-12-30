class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info, :statuses

  def statuses
    Timeline.for_user(object).map(&:id)
  end

  # def followers
  #   object.followers.map(&:username)
  # end

  # def following
  #   object.following.map(&:username)
  # end

  has_many :followers, embed: :ids
  has_many :following, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
