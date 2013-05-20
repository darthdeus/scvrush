module Admin
  class PostsController < AdminController
    def index
      @posts = Post.all
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(params[:post])

      if @post.save
        flash[:success] = "Post was successfuly created."
        redirect_to admin_posts_path
      else
        render :new
      end
    end

    def edit
      @post = Post.find(params[:id])
    end

    def update
      @post = Post.find(params[:id])

      if @post.update_attributes(params[:post])
        flash[:success] = "Post was successfuly updated."
        redirect_to admin_posts_path
      else
        render :new
      end
    end

    def destroy
      @post = Post.find(params[:id])
      @post.destroy
      flash[:success] =  "Post was deleted."
      redirect_to admin_posts_path
    end

  end
end
