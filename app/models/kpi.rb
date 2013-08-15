class Kpi
  def activated_account_count
    User.where("expires_at = NULL AND created_at > ?", 1.week.ago).size
  end

  def tournament_signups
    Signup.where("created_at > ? AND status = ?", 1.week.ago, Signup::REGISTERED).size
  end

  def tournament_checkins
    Signup.where("created_at > ? AND status = ?", 1.week.ago, Signup::REGISTERED).size
  end
end
