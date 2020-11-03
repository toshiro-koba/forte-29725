class NotificationsController < ApplicationController
  def index
    @user = current_user
    notifications = Notification.check(current_user)
    @notifications = Kaminari.paginate_array(notifications).page(params[:page]).per(5)
  end
end
