class Rating < ActiveRecord::Base
  has_many :video_ratings
  has_many :videos, through: :video_ratings
end
