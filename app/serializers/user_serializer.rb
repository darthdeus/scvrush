class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :race, :image, :bnet_info, :status_ids, :expires_at,
             :server, :about

  has_many :tournaments, embed: :ids, include: true

  def include_tournaments?
    scope.id == object.id
  end

  # def status_ids
  #   Timeline.for_user(object).map(&:id)
  # end

  def image
    object.avatar.url(:thumb)
    "/assets/LogoBig.png"
  end

end
