ActiveAdmin.register Post do
  index do
    column :id
    column :title
    column :featured_image
    column :tag_list
    column :created_at
    column :status
    column :user
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :title
      f.input :featured_image
      f.input :tag_list
      f.input :created_at
      f.input :status
      f.input :content
      f.input :user
    end
    f.buttons
  end
end
