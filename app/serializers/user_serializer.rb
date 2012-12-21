class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info

  # TODO - this should be the timeline statuses, not the authored ones
  has_many :statuses, embed: :ids
  has_many :followers, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
