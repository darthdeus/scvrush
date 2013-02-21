class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :race, :image, :bnet_info, :status_ids, :expires_at

  def status_ids
    Timeline.for_user(object).map(&:id)
  end

  # has_many :followers, embed: :ids
  # has_many :following, embed: :ids

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
