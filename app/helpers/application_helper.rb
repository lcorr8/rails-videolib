module ApplicationHelper

  def hard_lessons
    #show videos that have a reting of 5
    @hard_ratings = VideoRating.all.where(rating_id: 5)
    @hard_ratings.to_a.uniq!{|rating| rating.video_id}
  end

#OVERALL STATS:
  #all flatiron videos
  def flatiron_videos
    @videos = Video.all 
    @flatiron_videos = @videos.where(:flatiron => true)
  end

  #most watched videos (top 10 by everyone)

  #hardest videos (top 10 videos with most 5 ratings)


#PERSONAL STATS:

  #watched flatiron videos by current user, for count.
  def seen_flatiron_videos
    WatchedVideo.where(:user_id => current_user, :flatiron => true)
  end

  #Videos you thought were difficult, to re-watch?

  #videos you have yet to see?

  #progress bar of % flatiron videos watched
  #http://getbootstrap.com/components/#progress

  #progress bar for % of total videos watched
  #http://getbootstrap.com/components/#progress

end
