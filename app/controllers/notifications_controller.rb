class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.order(created_at: :desc).limit(30)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
