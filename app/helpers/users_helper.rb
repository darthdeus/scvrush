module UsersHelper

  def user_race_icon(user)
    return unless user
    race_icon(user.race)
  end

  # Return image for a given race
  def race_icon(race)
    case race
      when "zerg"    then image_tag("race_zerg_icon.png", class: "race-icon")
      when "protoss" then image_tag("race_protoss_icon.png", class: "race-icon")
      when "terran"  then image_tag("race_terran_icon.png", class: "race-icon")
      when "random"  then image_tag("race_random_icon.png", class: "race-icon")

      # else raise ArgumentError, "Invalid race"
    end
  end

  # Return image for a given league
  def league_icon(league)
    image = case league
      when "Bronze"   then "league_bronze_icon.png"
      when "Silver"   then "league_silver_icon.png"
      when "Gold"     then "league_gold_icon.png"
      when "Platinum" then "league_platinum_icon.png"
      when "Diamond"  then "league_diamond_icon.png"
      when "Master"  then "league_masters_icon.png"

      # else raise ArgumentError, "Invalid race"
    end

    image_tag image, class: "user_league_icon" if image
  end

end
