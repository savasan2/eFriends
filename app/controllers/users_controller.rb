class UsersController < ApplicationController
  def index
    users = User.where(genre_id: current_user.genre_id).where.not(id: current_user.id).where.not(id: current_user.following_user).order("updated_at DESC")
    current_user.now = 0
    current_user.save
    @user = users[current_user.now]
    if @user.nil?
    redirect_to root_path
    end
  end

  def register
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      redirect_to  users_path
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def matched
    @users = current_user.following_user & current_user.follower_user
  end

  def destroy
    user = User.find(current_user.id)
    user.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:genre_id,:name,:image,:gender,:introduction)
  end

end
