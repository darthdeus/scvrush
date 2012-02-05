# encoding: utf-8
module ApplicationHelper
  def arrowed_header(text, cls = "")
    "<h2 class='arrowed #{cls}'>#{text}<span class='arrows'>»</span></h2>".html_safe
  end

  def coach(tags)
    tag_path("coach," + tags)
  end

  def m(string)
    RDiscount.new(string).to_html.html_safe
  end

  def tag_link(tag)
    name = tag.name.titleize
    name = name.upcase if %w(Na Eu Sea Kr).include? name
    link_to name, coach(tag.name)
  end
end
