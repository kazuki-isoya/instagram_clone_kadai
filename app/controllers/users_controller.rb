class UsersController < ApplicationController
  before_action :login_check, only: [:edit, :update]
  before_action :logged_in?, only: [:edit, :update]
  before_action :current_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: 'アカウントが作成されました'
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end


  def edit
    @user = User.find(params[:id])
    if current_user == @user
      @user = User.find(params[:id])
    else
      redirect_to root_url, notice: '他のユーザーのプロフィールは編集できません！'
    end
  end


  def update
    @user = User.find(params[:id])
    if current_user == @user
      @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:notice] = 'ユーザー情報を編集しました!'
        render :show
      else
        flash.now[:notice] = 'ユーザー情報の編集に失敗しました!'
        render :show
      end

    else
        redirect_to root_url, notice: '他のユーザーのプロフィールは編集できません！'
    end
  end

  def favorite_index
    @favorites = current_user.favorite_feeds
  end




  private

  def user_params
    params.require(:user).permit(:name, :email, :image, :password, :password_confirmation)
  end

end
