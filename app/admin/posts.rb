ActiveAdmin.register Post do
  index do
    column :id
    column :title
    column :featured_image
    column :tag_list
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :featured_image
      f.input :tag_list
      # f.text_area :content
    end
    f.buttons
  end
end
