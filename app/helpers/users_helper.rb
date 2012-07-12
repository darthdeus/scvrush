module UsersHelper

  def quit_practice_buddy_button
    link_to("Quit Practice Buddy",
        { :controller => :practice, :action => :quit },
        :class => "btn", :'data-loading-text' => 'loading...')
  end

  def join_practice_buddy_button
    link_to "Join Practice Buddy",
      { :controller => :practice, :action => :join },
      :class => "btn", :'data-loading-text' => 'loading...'
  end

  def conditional_user_info(user, attr)
    if user.read_attribute("display_#{attr}")
      user_info(user, attr)
    end
  end

  def user_info(user, attr)
    if user.read_attribute(attr).present?
      out = ""
      out += content_tag :dt, attr.titleize
      out += content_tag :dd, user.send(attr)
      out.html_safe
    end
  end

  def info_for_user(user, info, conditional_info)
    output = ""
    info.each do |attr|
      data = user_info(user, attr)
      output += data if data
    end
    conditional_info.each do |attr|
      data = conditional_user_info(user, attr)
      output += data if data
    end

    output.html_safe
  end
end
