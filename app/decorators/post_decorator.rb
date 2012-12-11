class PostDecorator < Draper::Base
  decorates :post

  def link_with_image
    h.link_to post, class: "block" do
      h.image_tag post.featured_image.url
    end
  end

  def coach_post?
    post.tag_list.include? "coach"
  end

  def as_json(options = {})
    model.as_json(options)
  end

end
