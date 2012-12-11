class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :image

  def id
    object.to_param
  end

  def image
    object.featured_image_url(:thumb)
  end

end
