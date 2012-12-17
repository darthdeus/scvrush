class SignupSerializer < ActiveModel::Serializer
  attributes :id, :tournament_id, :user_id

  # has_one :user
end
