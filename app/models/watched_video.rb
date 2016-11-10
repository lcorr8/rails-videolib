class WatchedVideo < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates :watched, presence: true
  validates :video_id, presence: true
  validates :rating_id, presence: true
end