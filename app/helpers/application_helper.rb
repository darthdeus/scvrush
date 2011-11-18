# encoding: utf-8
module ApplicationHelper
  def arrowed_header(text, cls = "")
    "<h2 class='arrowed #{cls}'>#{text}<span class='arrows'>»</span></h2>".html_safe
  end
    
end
