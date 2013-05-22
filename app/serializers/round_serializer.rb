class RoundSerializer < ActiveModel::Serializer
  attributes :id, :number, :bo, :text, :tournament_id, :human_name

  has_many :matches, embed: :ids
end
