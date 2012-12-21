class StatusSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id, :timeline_id
end
