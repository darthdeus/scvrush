class RoundSerializer < ActiveModel::Serializer
  attributes :id, :number, :bo, :text, :tournament_id

  has_many :matches, embed: :ids
end
