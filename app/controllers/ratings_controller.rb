class RatingsController < ApplicationController
  def new
    @video = Video.find(params[:video_id])
    @rating = @video.video_ratings.build
  end

  def create
    @video = Video.find(params[:video_id])
    @rating = @video.video_ratings.build(rating_params)
    if @rating.save
      redirect_to video_path(@video)
    else
      #raise "@rating did not save".inspect
      render :new
    end
  end

  private

  def rating_params
    params.require(:video_rating).permit(:rating_id, :reason)
  end
end
