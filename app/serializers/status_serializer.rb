class StatusSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :username

  def username
    object.user.username
  end

end
