class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    users = User.where(genre_id: current_user.genre_id)
    if i >= 1
      i = i + 1
    else
      i = 0
    end
    @user = users[i]
    render "users/index"

  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to root_path
  end
end
