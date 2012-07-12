# encoding: utf-8
module ApplicationHelper
  def arrowed_header(text, cls = "")
    "<h2 class='arrowed #{cls}'>#{text}<span class='arrows'>»</span></h2>".html_safe
  end

  def coach(tags)
    tag_path("coach," + tags)
  end

  def m(string)
    RDiscount.new(string).to_html.html_safe if string
  end

  def meta_description(&block)
    if content_for?(:description)
      yield(:description)
    else
      I18n.t("meta_description")
    end
  end

  def meta_keywords
    I18n.t("meta_keywords")
  end

  def tag_link(tag)
    name = tag.name.titleize
    name = name.upcase if %w(Na Eu Sea Kr).include? name
    link_to name, coach(tag.name)
  end


  def flash_class(type)
    case type
    when :notice  then "alert-info"
    when :success then "alert-success"
    when :info    then "alert-info"
    when :error   then "alert-error"
    end
  end

    # Create a bootstrap icon
    def bootstrap_icon(cls, text)
      content_tag(:i, nil, class: cls, title: text)
    end

    # Return CRUD action buttons
    def get_action_buttons(model)
      content_tag :div do
        content =  link_to edit_polymorphic_path([:admin, model]) do
          bootstrap_icon('icon-edit', 'edit')
        end

        icon = bootstrap_icon('icon-remove', 'delete')
        delete_link = link_to(polymorphic_path([:admin, model]), method: :delete,
         data: { confirm: "Are you sure?" }) { icon }

        content << delete_link
        return content.html_safe
      end
    end


    # Public: A little wrapper for main navigation links,
    #
    # text - A string of text to be displayed on the link
    # path - URL of the link
    # current_controller - name of the controller where the
    #                      button should be active
    #
    # Returns a String of HTML for the link
    def main_nav_link(text, path, current_controller)
      # get the current controller name
      params = request.env["action_dispatch.request.path_parameters"]
      # engine namespace
      ctrl = params[:controller].sub(/^admin\//, '')

      cls = "active" if ctrl == current_controller
      content_tag(:li, link_to(text, path), :class => cls)
    end


  end
