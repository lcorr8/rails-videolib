class Rating < ActiveRecord::Base
  has_many :video_ratings
  has_many :videos, through: :video_ratings

  validates :stars, presence: true
  validates :stars, inclusion: 1..5
end
