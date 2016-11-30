class RatingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create]
  before_action :set_video
  before_action :set_rating, only: [:edit, :update, :destroy]
  

  #this ratings controller handles the video-ratings (join table rows)
  #there are only 5 ratings and they come pre-made, users dont make any more.
  def new
    @rating = @video.video_ratings.build
    authorize @rating
  end

  def create
    @rating = @video.video_ratings.build(rating_params)
    @rating.user = @user
    authorize @rating
    if @rating.save
      redirect_to video_path(@video)
    else
      render :new
      #raise "Stop"
    end
  end

  def show
    #no route atm, no need to show the rating in a show page
    #@user_ratings = @video.video_ratings.select{ |rating| rating.user_id == @user.id }
  end

  def index
    @user_ratings = @video.video_ratings.where(user_id: current_user.id)
  end

  def edit
    authorize @rating
  end

  def update
    authorize @rating
    if @rating.update(rating_params)
      redirect_to video_path(@video)
    else
      render :edit
    end
  end

  def destroy 
    authorize @rating
    @rating.destroy
    redirect_to video_path(@video)
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
    #scope by user in the future
  end

  def set_rating
    @rating = VideoRating.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def rating_params
    params.require(:video_rating).permit(:rating_id, :reason)
  end
end
