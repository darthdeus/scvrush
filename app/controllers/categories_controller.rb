class CategoriesController < ApplicationController
  respond_to :js
  
  def create
    @category = Category.new(params[:category])
    @saved = @category.save
  end
end
