class WatchedController < ApplicationController
  before_action :set_video
  before_action :set_user
  before_action :set_watched_video

  def watched
    if !@video.video_watched(@user, @video)
      @watched_video = @video.watched_videos.build(watched_params)
      @watched_video.user = @user
      @watched_video.save 
      redirect_to new_video_rating_path(@video)
    else
      redirect_to video_path(@video)
      flash[:error] = "You have already marked this video watched, are you trying to delete the view status?"
    end
    #only psitive views, if you havent seen a video then you dont have an entry in the join table,
    # if you want to delete a view, then you just delete the entry from the table
  end

  def destroy
    if @video.video_watched(@user, @video)
      @watched_video.destroy
      redirect_to video_path(@video)
    else
      redirect_to video_path(@video)
      flash[:error] = "There is no view status to delete, try marking the video watched first"
    end
  end







  private

  def watched_params
    params.require(:video).permit(:watched)
  end

  def set_video
    @video = Video.find(params[:id])
  end

  def set_user
    @user = current_user
  end

  def set_watched_video
    @watched_video = WatchedVideo.find_by(user_id: @user.id, video_id: @video.id)
  end

end