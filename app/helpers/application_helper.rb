module ApplicationHelper

  def hard_lessons
    #show videos that have a reting of 5
    @hard_ratings = VideoRating.all.where(rating_id: 5)
    @hard_ratings.to_a.uniq!{|rating| rating.video_id}
  end

#OVERALL STATS:

  #most watched videos (top 10 by everyone)

  #hardest videos (top 10 videos with most 5 ratings)


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

  #Videos you thought were difficult, to re-watch?

  #videos you have yet to see?

  #progress bar of % flatiron videos watched
  #http://getbootstrap.com/components/#progress

  #progress bar for % of total videos watched
  #http://getbootstrap.com/components/#progress

end
