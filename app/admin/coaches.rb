ActiveAdmin.register Coach do
  index do
    column :id
    column :title
    column :tag_list
    column :post
    column :order
    default_actions
  end

  form do |f|
    f.inputs "Details" do
    	f.input :title
      f.input :tag_list
	    f.input :post
      f.input :order      
    end
    f.buttons
  end
  
end
