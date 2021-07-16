class Admin::UsersController < ApplicationController
  def index
    @users = User.all.where.not(admin: true)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

end
