ActiveAdmin.register Post do
  index do
    column :id
    column :title
    column :featured_image
    column :tags
    default_actions
  end
end
