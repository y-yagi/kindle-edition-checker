class SessionsController < ApplicationController
  skip_before_action :check_logged_in
  protect_from_forgery except: [:create]

  def new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    @user.update_if_needed!(auth_hash)
    session[:user_id] = @user.id
    redirect_to root_path
  end

  def destroy
    session.destroy
    redirect_to login_path
  end

  protected
    def auth_hash
      request.env['omniauth.auth']
    end
end
