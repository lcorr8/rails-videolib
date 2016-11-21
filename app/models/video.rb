class Video < ActiveRecord::Base
  belongs_to :section

  has_many :video_ratings
  has_many :ratings, through: :video_ratings
  has_many :watched_videos
  has_many :users, through: :watched_videos

  validates :name, presence: true
  validates :link , presence: true, uniqueness: true
  validates :year, presence: true
  #works for only LV videos, if user wants to add another resource video this validation
  #becomes useless by limiting them to 3 years
  #, :inclusion => { :in => %w(2014 2015 2016), :message => "%{value} is not a valid cohort year for LV" } 
  validates :section_id, presence: true 

  scope :sixteen, -> { where(year: "2016" ) }
  scope :fifteen, -> { where(year: "2015" ) }
  scope :fourteen, -> { where(year: "2014" ) }
  scope :flatiron, -> { where(flatiron: true) }
  scope :general, -> { where(flatiron: false) }
  
  def section=(section)
      section = Section.find_or_create_by(name: section[:name])
      self.section_id = section.id
  end

  def video_watched(user, video)
    @watched_video = WatchedVideo.where(user_id: user.id, video_id: video.id).first
    if @watched_video && @watched_video.watched == true
      true
    else
      false
    end
  end

  #watched flatiron videos by user
  def self.watched_flatiron_videos(current_user)
    joins(:watched_videos).where(flatiron: true).where("watched_videos.user_id = ?", current_user.id)
  end

  #
  

end
