class Settings::NotificationsController < ApplicationController
  before_action :set_user

  def index
    @user = current_user
  end

  def update
    if @user.update(user_params)
      redirect_to settings_notifications_url
    else
      render :index
    end
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email_notification)
    end
end
