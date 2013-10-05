class ActivationsController < AuthenticatedController

  def new
    @user = current_user
  end

  def create
    @user = current_user
    @user.validate_trial_email = true

    if @user.update_attributes(params[:user])
      @user.update_attribute(:expires_at, nil)
      redirect_to dashboard_path, notice: "Your account was activated, welcome to SCV Rush!"
    else
      render :new
    end
  end

end
