class UsersController < ApplicationController
  before_action :login_check
  before_action :logged_in?
  before_action :current_user
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end


def edit
  if current_user == @user
    @user = User.find(params[:id])
  else
    redirect_to root_url, notice: '他のユーザーのプロフィールは編集できません！'
  end
end


def update
  if current_user == @user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を編集しました。'
      render :edit
    else
      flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
      render :edit
    end

  else
      redirect_to root_url, notice: '他のユーザーのプロフィールは編集できません！'
  end
end




  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

end
