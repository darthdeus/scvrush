class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :participant_count, :image_name, :starts_at, :seeded, :user_id

  has_many :rounds, embed: :ids
  has_many :users, embed: :ids

  def starts_at
    object.starts_at.strftime "%Y-%m-%d %H:%M"
  end

  def attributes
    hash = super
    if scope
      player = TournamentPlayerDecorator.new(scope, self)
      hash["is_registered"] = player.registered? || player.checked_in?
      hash["is_checked"] = player.checked_in?
    end

    hash
  end

end
