class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :race, :image, :bnet_info

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
