class RelationshipsController < ApplicationController
  def follow
    current_user.follow(params[:id])
    users = User.where(genre_id: current_user.genre_id).where.not(id: current_user.id).where.not(id: current_user.following_user).order("updated_at DESC")
    @user = users[current_user.now] #フォローしたら配列が1つ減るため自動的に1つ繰り上がる
    if @user.nil?
      redirect_to users_path
    else
      render "users/index"
    end
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to root_path
  end

  def skip
    current_user.follow(params[:id])
    users = User.where(genre_id: current_user.genre_id).where.not(id: current_user.id).where.not(id: current_user.following_user).order("updated_at DESC")
    current_user.now = current_user.now + 1 #配列の次のユーザー
    current_user.save
    @user = users[current_user.now]
    if @user.nil?
      redirect_to users_path
    else
      render "users/index"
    end
  end
end