class Admin::UsersController < ApplicationController
  before_action :if_not_admin

  def index
    @users = User.page(params[:page]).per(10).where.not(admin: true)
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to admin_users_path
  end

  private

  def if_not_admin
    redirect_to user_path unless current_user.admin?
  end

end
