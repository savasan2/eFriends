class UsersController < ApplicationController
  def index
    users = User.where(genre_id: current_user.genre_id)
  
    @user = users[0]

  end

  def register
    @user = User.find(current_user.id)
  end

  def update
    user = User.find(current_user.id)
    if user.update(user_params)
      redirect_to  user_path(current_user.id)
    else
      redirect_to user_register_path
    end
  end

  def edit
    @user = User.find(current_user.id)
  end

  def match
    @user = current_user
  end
  private

  def user_params
     params.require(:user).permit(:genre_id,:name,:image,:gender,:introduction)
  end

end
