module Admin
  class PostsController < AdminController
    def index
      @posts = Post.all
    end

    def edit
      @post = Post.find(params[:id])
      @tournaments = Tournament.all
    end

    def update
      @post = Post.find(params[:id])
      if params[:tournament_id].empty?
        @post.tournament = nil
      else
        @post.tournament = Tournament.find(params[:tournament_id])
      end

      @post.save!
      flash[:success] = "Post was successfuly updated."
      redirect_to posts_path
    end

  end
end
