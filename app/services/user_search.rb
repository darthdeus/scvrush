class UserSearch
  def self.search(query)
    if query.present?
      User.where("username ILIKE ? OR bnet_username ILIKE ?",
                 "%#{query}%", "%#{query}%")
    else
      User
    end
  end
end
