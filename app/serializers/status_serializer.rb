class StatusSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :user_id

  def user_id
    object.user.username
  end

end
