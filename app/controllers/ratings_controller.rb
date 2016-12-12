class RatingsController < ApplicationController
  #the ratings controller does not create ratings but rather handles the video-ratings (join table rows)
  #there are only 5 ratings and they come pre-made, users dont make any more.

  before_action :authenticate_user!
  before_action :set_user, only: [:create, :index]
  before_action :set_video
  before_action :set_rating, only: [:edit, :update, :destroy]
  

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
    @user_ratings = @video.user_ratings(@user)
    #do i need to authorize if im scoping by current user ratings?
    authorize @user_ratings 
  end

  def edit
    #scoping by video to account for nested url
    if @video.video_ratings.include?(@rating)
      authorize @rating
    else 
      redirect_to video_path(@video)
      flash[:error] = "That rating does not belong to this video, nice try."
    end
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
