class Rating < ActiveRecord::Base
  has_many :video_ratings
  has_many :videos, through: :video_ratings

  validates :stars, presence: true
  validates :stars, inclusion: 1..5

  #1 = "so easy I can do it in my sleep"
  #2 = "oh this old thing?"
  #3 = "yeah I know how to do that"
  #4 = "theoretically i know how to do it, just have to look up some syntax..."
  #5 = "gulp....help?"
  def stars_with_description
    "#{self.stars}: #{self.description}"
  end
end
