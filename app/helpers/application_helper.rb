module ApplicationHelper
  #presentation logic that needs to be shared across more than one view

  def hard_lessons #(should pass the current user? or just call it inside the method?)
    #show videos that have a reting of 5 by the current_user
    @hard_ratings = VideoRating.all.where(rating_id: 5, user_id: current_user.id)
    @hard_ratings.to_a.uniq!{|rating| rating.video_id}
    @hard_ratings
  end
  #what is best practice for the stats? to be helpers like above?
  # or to be arel queries in the model?

  #has the current user rated any flatiron videos?
#  def rated_any_flatiron_videos?
#    @videos = WatchedVideo.all
#    if @videos.where(:user_id => @user.id)
#      true
#    else
#      false
#    end
#  end

end
