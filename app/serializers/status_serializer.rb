class StatusSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at, :user_id
end
