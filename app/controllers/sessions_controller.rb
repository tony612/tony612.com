class SessionsController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  def new
    redirect_to '/auth/github'
  end

  def create
    warden.authenticate!(:github)
    redirect_to '/', notice: "Authing successful"
  end

  def unauthenticated
    logger.debug "Unauthenticated"
    redirect_to '/', alert: "Unauthenticated!"
  end

  def destroy
    warden.logout
    redirect_to '/', notice: "Logged out"
  end

  protected

  def warden
    request.env['warden']
  end

  def require_no_authentication
    redirect_to root_path if admin_signed_in?
  end
end
