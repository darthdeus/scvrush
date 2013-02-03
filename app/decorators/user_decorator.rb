class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_img
    h.gravatar email
  end

  def as_json(options = {})
    # TODO - move this to the serializer
    as_json(options).merge("gravatar" => avatar_img)
  end

  # Link to the user's twitter
  def facebook_link
    if user.facebook.present?
      h.link_to h.image_tag("glyphicons_390_facebook.png"), facebook
    end
  end

  # Link to the user's twitter
  def twitter_link
    if user.twitter?
      h.link_to h.image_tag("glyphicons_392_twitter.png"), twitter
    end
  end

  def action_buttons
    h.get_action_buttons(source)
  end

  def link
    h.link_to username, source
  end
end
