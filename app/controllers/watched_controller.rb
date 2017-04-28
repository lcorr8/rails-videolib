class WatchedController < ApplicationController
  before_action :set_video, only: [:watched, :destroy]
  before_action :set_user, only: [:watched,:destroy]
  before_action :set_watched_video, only: [:destroy]

  #marks a video watched if there are no watchedvideo records in the joins table
  def watched
    if !@video.video_watched?(@user, @video)
      @watched_video = @video.watched_videos.build(watched_params)
      @watched_video.user = @user
      @watched_video.save 
      respond_to do |format|
        format.html { redirect_to video_path(@video) }
        format.json { render json: @video }
      end
    else
      flash[:error] = "You have already marked this video watched, are you trying to delete the view status?"
      respond_to do |format|
        format.html { redirect_to video_path(@video) }
        format.json { render json: @video }
      end
    end
    #only positive views, if you havent seen a video then you dont have an entry in the join table,
    # if you want to delete a view, then you just delete the entry from the table
  end

  def destroy
    if @video.video_watched?(@user, @video)
      #watched_params error "watched cant be blank", 
      #currently passing data: {video: { watched: false }}, to ajax post, not used
      #watchedByCurrentUser prototype method uses a video's users(watchedvideo entries)
      @watched_video.destroy
      respond_to do |format|
        format.html { redirect_to video_path(@video) }
        format.json { render json: @video }
      end
    else
      flash[:error] = "There is no view status to delete, try marking the video watched first"
      respond_to do |format|
        format.html { redirect_to video_path(@video) }
        format.json { render json: @video }
      end
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