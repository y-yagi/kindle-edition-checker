class Settings::NotificationsController < ApplicationController
  before_action :set_user

  def index
    @user = current_user
  end

  def update
    update_params = user_params
    update_params.extract!(:pushbullet_api_token) if update_params[:pushbullet_api_token] == @user.maskd_pushbullet_api_token
    if @user.update(update_params)
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
      params.require(:user).permit(
        :email_notification, :browser_notification, :browser_subscription_id,
        :pushbullet_notification, :pushbullet_api_token
      )
    end
end
