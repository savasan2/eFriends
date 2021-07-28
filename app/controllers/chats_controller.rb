class ChatsController < ApplicationController
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.new
      @room.save
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    @chats = @room.chats.order(id: "DESC")
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    chat = current_user.chats.new(chat_params)
    chat.save
    old_notification = Notification.where(visitor_id: current_user.id, visited_id: params[:id], action: "chat")
    if old_notification.any?
      old_notification.destroy_all #同じ組み合わせの古い通知レコードは削除
    end
    notification = current_user.active_notifications.new(chat_id: chat.id, visited_id: params[:id], action: "chat")
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    @room = user_rooms.room
    @chats = @room.chats.order(id: "DESC")
    @chat = Chat.new(room_id: @room.id)
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

end
