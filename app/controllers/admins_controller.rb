class AdminsController < ApplicationController
  before_filter :authenticate_admin!
  def show
    @admin = Admin.find(params[:id])
  end
end
