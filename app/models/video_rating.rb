class VideoRating < ActiveRecord::Base
  belongs_to :video 
  belongs_to :rating 

  validates :reason, presence: true
  validates :video_id, presence: true
  validates :rating_id, presence: true
end
