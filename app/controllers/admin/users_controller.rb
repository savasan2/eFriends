class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10).where.not(admin: true)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

end
