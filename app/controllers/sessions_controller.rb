class SessionsController < ApplicationController
  # before_action :login_check, only: [:new, :edit, :update, :destroy]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end

  private

  # def login_check
  #   unless logged_in?
  #     # flash[:alert] = "ログインしてください"
  #     redirect_to root_path, notice: 'ログインしてください'
  #   end
  # end

end
