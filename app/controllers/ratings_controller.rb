class RatingsController < ApplicationController
  before_action :set_video
  before_action :set_rating, only: [:edit, :update, :destroy]

  def new
    @rating = @video.video_ratings.build
  end

  def create
    #raise params.inspect
    @rating = @video.video_ratings.build(rating_params)
    if @rating.save
      redirect_to video_path(@video)
    else
      #raise "@rating did not save".inspect
      render :new
    end
  end

  def edit
  end

  def update
    if @rating.update(rating_params)
      redirect_to video_path(@video)
    else
      render :edit
    end
  end

  def destroy 
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

  def rating_params
    params.require(:video_rating).permit(:rating_id, :reason)
  end
end
