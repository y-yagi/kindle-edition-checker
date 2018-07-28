class IndexController < ApplicationController
  skip_before_action :check_logged_in

  def index
    redirect_to books_path if logged_in?
  end
end
