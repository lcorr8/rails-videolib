module ApplicationHelper

  def hard_lessons
    #show videos that have a reting of 5
    @hard_ratings = VideoRating.all.where(rating_id: 5)
    @hard_ratings.to_a.uniq!{|rating| rating.video_id}
  end

#PERSONAL STATS:

  #has the current user rated any flatiron videos?
  def rated_any_flatiron_videos?
    @videos = WatchedVideo.all
    if @videos.where(:user_id => @user.id)
      true
    else
      false
    end
  end

end
