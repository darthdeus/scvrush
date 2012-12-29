class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :participant_count, :image_name, :starts_at, :seeded, :users

  def users
    object.users.map(&:username)
  end

  has_many :rounds, embed: :ids

  def attributes
    hash = super
    if scope
      player = TournamentPlayerDecorator.new(scope, self)
      hash["is_registered"] = player.registered?
    end

    hash
  end

end
