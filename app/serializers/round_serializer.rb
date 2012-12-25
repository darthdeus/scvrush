class RoundSerializer < ActiveModel::Serializer
  attributes :id, :number, :bo, :text

  has_many :matches, embed: :ids
end
