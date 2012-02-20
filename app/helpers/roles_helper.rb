module RolesHelper

  def manage_role_link(user, role, search)
    if user.has_role? role
      link_to "<i class='icon-remove'></i>#{role}".html_safe,
        role_path(id: role, user_id: user.id, search: search), method: :delete
    else
      link_to "<i class='icon-ok'></i>#{role}".html_safe,
        roles_path(user_id: user.id, role: role, search: search), method: :post
    end
  end
end
