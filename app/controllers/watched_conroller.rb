class WatchedController < ApplicationController

  def watched
    #mark video watched
    #create an entry in the join table with
    #user_id, video_id, true, save
    #redirect
    @watched_video = WatchedVideo.new(user_id: "#{current_user.id}", video_id: "", watched: true)
    @watched_video.save
    redirect_to sections_path
  end

end