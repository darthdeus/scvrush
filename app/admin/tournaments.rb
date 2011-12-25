ActiveAdmin.register Tournament do
  index do
    column :id
    column :name
    column :post
    column :starts_at
    default_actions
  end

end
