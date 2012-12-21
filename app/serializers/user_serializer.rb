class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info

  has_many :statuses, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
