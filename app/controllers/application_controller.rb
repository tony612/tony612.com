class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_admin!
    redirect_to login_path, alert: "Please sign in first" unless admin_signed_in?
  end

  def user_signed_in?
    warden.authenticated?
  end
  helper_method :user_signed_in?

  def admin_signed_in?
    user_signed_in? && User.find_from_user_info(warden.user)
  end
  helper_method :admin_signed_in?
end
