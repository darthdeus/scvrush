# encoding: utf-8
module ApplicationHelper
  def arrowed_header(text)
    "<h2 class='arrowed'>#{text}<span class='arrows'>»</span></h2>".html_safe
    # content_tag(:h2, :class => "arrowed") {
    #   ("Recent posts" + content_tag(:span, "»", :class => "arrows")).html_safe
    # }
  end
end
