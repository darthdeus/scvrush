module UsersHelper

  def quit_practice_buddy_button
    link_to("Quit Practice Buddy",
            { controller: :practice, action: :quit },
            class: "btn btn-mini", :'data-loading-text' => 'loading...')
  end

  def join_practice_buddy_button
    link_to "Join Practice Buddy",
      { controller: :practice, action: :join },
      class: "btn btn-primary", :'data-loading-text' => 'loading...'
  end

  # Return image for a given race
  def race_icon(race)
    case race
      when "Zerg"    then image_tag("race_zerg_icon.png")
      when "Protoss" then image_tag("race_protoss_icon.png")
      when "Terran"  then image_tag("race_terran_icon.png")
      when "Random"  then image_tag("race_random_icon.png")

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
