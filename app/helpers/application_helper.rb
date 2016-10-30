module ApplicationHelper

  def hard_lessons
    #show videos that have a reting of 5
    @hard_ratings = VideoRating.all.where(rating_id: 5)
    @hard_ratings.to_a.uniq!{|rating| rating.video_id}
  end

end
