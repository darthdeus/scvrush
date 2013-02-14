class PostDecorator < Draper::Decorator
  decorates :post

  def link_with_image
    h.link_to post, class: "block" do
      h.image_tag model.featured_image.url
    end
  end

  def coach_post?
    model.tag_list.include? "coach"
  end

  def as_json(options = {})
    model.as_json(options)
  end

end
