class FeedsController < ApplicationController
  before_action :login_check
  before_action :logged_in?
  before_action :current_user
  before_action :set_feed, only: [:show, :edit, :update, :destroy]

  def index
    @feeds = Feed.all
  end

  def show
    @favorite = current_user.favorites.find_by(feed_id: @feed.id)
  end

  def new
    if params[:back]
      @feed = Feed.new(feed_params)
    else
      @feed = Feed.new
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render :new if @feed.invalid?
  end

  def edit
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if params[:back]
      render :new
    else
      if @feed.save
        FeedMailer.feed_mail(@feed).deliver

        redirect_to feeds_path, notice: "投稿しました！"
      else
        render 'new'
      end
    end
  end


  def update
    respond_to do |format|
      if @feed.update(feed_params)
        format.html { redirect_to @feed, notice: '画像をアップデートしました' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @feed.destroy
    respond_to do |format|
      format.html { redirect_to feeds_url, notice: '投稿を削除しました' }
    end
  end

  private

  def set_feed
    @feed = Feed.find(params[:id])
  end

  def feed_params
    params.require(:feed).permit(:content, :image, :image_cache)
  end


end
