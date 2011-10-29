class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(params[:category])
    if @category.save
      redirect_to categories_path, :notice => "Category added"
    else      
      render "new"
    end
  end
end
