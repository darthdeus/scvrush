module Admin
  class UsersController < AdminController

    def index
      @users = []

      respond_to do |format|
        format.html

        format.json do
          view_context

          fields = %w[username email bnet_username]
          columns = %w[username email bnet_username bnet_code skype]

          table = Datable.new(User, fields, columns, params) do |user|
            user = UserDecorator.new(user)

            [
              user.link,
              user.email,
              user.bnet_info,
              user.bnet_code,
              user.skype,
              user.action_buttons
            ]
          end

          render json: table
        end
      end
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "User was succesfuly created"
        redirect_to admin_users_path
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:success] = "User was updated."
        redirect_to users_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      # @user.destroy
      redirect_to users_path, success: "User was successfully removed."
    end
  end
end
