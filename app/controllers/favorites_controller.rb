class FavoritesController < ApplicationController
  before_action :login_check
  before_action :logged_in?
  before_action :current_user

  def create
    favorite = current_user.favorites.create(feed_id: params[:feed_id])
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り登録しました"
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id]).destroy
    redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り解除しました"
  end

  

end
