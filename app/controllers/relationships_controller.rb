class RelationshipsController < ApplicationController
  def follow
    user = User.find(params[:id])
    current_user.follow(user.id)
    if user.following?(current_user) #フォローされていたら通知を作成する
      notification = current_user.active_notifications.new(visited_id: user.id, action: 'follow')
      notification.save if notification.valid? #自分用の通知
      notification = user.active_notifications.new(visited_id: current_user.id, action: 'follow')
      notification.save if notification.valid? #相手用の通知
    end
    users = User.where(genre_id: current_user.genre_id).where.not(id: current_user.id).where.not(admin: true).where.not(id: current_user.following_user).order("updated_at DESC")
    @user = users[current_user.now] #フォローしたら配列が1つ減るため自動的に1つ繰り上がる
    if @user.nil?
      redirect_to users_path
    else
      render "users/index"
    end
  end

  def skip
    users = User.where(genre_id: current_user.genre_id).where.not(id: current_user.id).where.not(admin: true).where.not(id: current_user.following_user).order("updated_at DESC")
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
