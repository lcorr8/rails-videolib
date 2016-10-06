class RatingsController < ApplicationController
  before_action :set_video

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
    @rating = VideoRating.find(params[:id])
  end

  def update
    #raise params.inspect
    @rating = VideoRating.find(params[:id])
    if @rating.update(rating_params)
      redirect_to video_path(@video)
    else
      render :edit
    end
  end

  private

  def set_video
    @video = Video.find(params[:video_id])
    #scope by user in the future
  end

  def rating_params
    params.require(:video_rating).permit(:rating_id, :reason)
  end
end
