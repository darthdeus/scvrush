class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      redirect_to articles_path, :notice => "Article added"
    else
      render "new"
    end
  end
  
  def destroy
    Article.destroy(params[:id])
    redirect_to articles_path, :notice => "Article removed"
  end

end
