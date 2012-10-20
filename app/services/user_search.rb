class UserSearch
  def self.search(query)
    if query.present?
      User.where("username ILIKE ? OR bnet_username ILIKE ?",
                 "%#{params[:search]}%",
                 "%#{params[:search]}%")
    else
      User
    end
  end
end
