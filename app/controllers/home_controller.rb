class HomeController < AuthenticatedController

  def index
    redirect_to dashboard_path unless current_user.trial?
  end

end
