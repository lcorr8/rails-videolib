class VideoRating < ActiveRecord::Base
  belongs_to :video 
  belongs_to :rating 
end
