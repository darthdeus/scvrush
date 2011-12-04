module UsersHelper
  def user_info(user, attr)
    if user.read_attribute(attr).present?
      content_tag :li do
        "#{attr.titleize}: #{user.send(attr)}".html_safe        
      end
    end
  end  
  
  def conditional_user_info(user, attr)
    if user.read_attribute("display_#{attr}")
      user_info(user, attr)
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
