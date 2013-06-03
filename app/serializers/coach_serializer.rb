class CoachSerializer < ActiveModel::Serializer
  attributes :id, :name, :about, :races, :servers, :languages
end
