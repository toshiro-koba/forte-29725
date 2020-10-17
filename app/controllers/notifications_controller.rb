class NotificationsController < ApplicationController
  def index
    @user = current_user
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end