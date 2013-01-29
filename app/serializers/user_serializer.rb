class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info, :statuses, :expires_at

  def statuses
    Timeline.for_user(object).map(&:id)
  end

  has_many :followers, embed: :ids
  has_many :following, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
