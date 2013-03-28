class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :text, :unread
end
