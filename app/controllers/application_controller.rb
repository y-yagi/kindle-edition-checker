class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :check_logged_in

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def check_logged_in
    redirect_to login_path unless logged_in?
  end
end
