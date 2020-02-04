class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def login_check
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end

end
