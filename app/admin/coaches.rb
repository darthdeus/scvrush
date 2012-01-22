ActiveAdmin.register Coach do
  index do
    column :id
    column :title
    column :post
    column :order
    default_actions
  end

  form do |f|
    f.inputs "Details" do
    	f.input :title
	    f.input :post
      f.input :order      
    end
    f.buttons
  end
  
end
