class ArticlesController < ApplicationController
  before_filter :require_login, :except => :index

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @category = Category.new
    @categories = Category.all
  end

  def create
    @article = Article.new(params[:article])
    @category = Category.find(@article.category)
    if @article.save
      redirect_to root_path, :notice => "Article published"
    else
      render "new"
    end
  end
  
  def destroy
    Article.destroy(params[:id])
    redirect_to articles_path, :notice => "Article removed"
  end

end
