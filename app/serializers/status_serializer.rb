class StatusSerializer < ActiveModel::Serializer
  attributes :id, :text, :user_id, :created_at
end
