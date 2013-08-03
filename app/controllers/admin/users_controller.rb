module Admin
  class UsersController < AdminController

    def index
      @users = []

      respond_to do |format|
        format.html

        format.json do
          view_context

          fields = %w[username email bnet_username]
          columns = %w[username email bnet_username bnet_code]

          table = Datable.new(User, fields, columns, params) do |user|
            [
              "<a href='/#/users/#{user.id}' target='_blank'>#{user.username}</a>",
              user.email,
              user.bnet_info,
              user.bnet_code,
              view_context.link_to("edit", edit_user_path(user)) + "&nbsp;".html_safe +
              view_context.link_to("delete", admin_user_path(user), method: "delete", data: { confirm: "Are you sure?" })
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
        flash[:notice] = "User was succesfuly created"
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
        flash[:notice] = "User was updated."
        redirect_to admin_users_path
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      redirect_to admin_users_path, notice: "User was successfully removed."
    end
  end
end
