class TournamentSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_name, :starts_at, :seeded, :user_id, :winner_id,
              :region, :max_players, :signups_count, :leagues, :channel, :description,
              :bo_preset, :map_preset, :rules, :map_info

  has_many :rounds, embed: :ids
  has_many :users, embed: :ids
  has_many :signups, embed: :ids

  def leagues
    object.leagues.try(:downcase)
  end

  def starts_at
    object.starts_at.iso8601
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
