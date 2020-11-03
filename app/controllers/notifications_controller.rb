class NotificationsController < ApplicationController
  def index
    @user = current_user
    @notifications = current_user.passive_notifications
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = @notifications.where.not(visitor_id: current_user.id)
    @notifications = Kaminari.paginate_array(@notifications).page(params[:page]).per(5)
  end
end
