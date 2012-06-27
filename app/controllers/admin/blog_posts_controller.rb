module Admin
  class BlogPostsController < AdminController
    def index
      @blog_posts = BlogPost.first(20)
    end

    def new
      @blog_post = BlogPost.new
    end

    def create
      @blog_post = BlogPost.new(params[:blog_post])
      if @blog_post.save
        flash[:success] = "Blog post was successfuly created."
        redirect_to admin_blog_posts_path
      else
        render :new
      end
    end

    def edit
      @blog_post = BlogPost.find(params[:id])
    end

    def update
      @blog_post = BlogPost.find(params[:id])
      if @blog_post.update_attributes(params[:blog_post])
        flash[:success] = "Blog post was successsfuly updated."
        redirect_to admin_blog_posts_path
      else
        render :edit
      end
    end

    def destroy
      @blog_post = BlogPost.find(params[:id])
      # @blog_post.destroy
      flash[:success] = "Blog post was successfuly removed."
    end

  end
end
