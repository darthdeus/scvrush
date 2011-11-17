module PostsHelper
  def featured_image(img)
    image_tag("http://scvrush.superinzerce.com/wp-content/uploads/#{img}", :alt => img)    
  end
end
