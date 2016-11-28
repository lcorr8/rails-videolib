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

  #watched general videos by user
  def self.watched_general_videos(current_user)
    joins(:watched_videos).where(flatiron: false).where("watched_videos.user_id = ?", current_user.id)
  end

  def self.most_watched_videos
#    Video.joins(:watched_videos).group("videos.name").count
#    => {"ActiveRecord Query Interface"=>1,
#         "Sugar Daddy"=>1,
#         "hedwig edited, made general"=>1,
#         "name"=>1,
#         "wig in a box"=>2}


    Video.joins(:watched_videos).select("videos.id, videos.name, count(videos.id) as watched_count").order("watched_count DESC").group("videos.id").limit(10).to_a
#    => [<Video:0x007ff21f759400 id: 1, name: "wig in a box">,
#        <Video:0x007ff21f759298 id: 2, name: "Sugar Daddy">,
#        <Video:0x007ff21f759130 id: 12, name: "hedwig edited, made general">,
#        <Video:0x007ff21f758fc8 id: 15, name: "name">,
#        <Video:0x007ff21f758e60 id: 79, name: "ActiveRecord Query Interface">]     
  end

  def self.hardest_videos
    Video.joins(:video_ratings).where("video_ratings.rating_id = ?", 5).select("videos.id, videos.name, count(videos.id) as hardest_rated_count").order("hardest_rated_count DESC").group("videos.id").limit(10).to_a
#       => [<Video:0x007ff21f6aaf68 id: 15, name: "name">,
#           <Video:0x007ff21f6aae00 id: 2, name: "Sugar Daddy">,
#           <Video:0x007ff21f6aac98 id: 1, name: "wig in a box">,
#           <Video:0x007ff21f6aab30 id: 3, name: "fantastic beasts and where to find them">]


#    Video.joins(:video_ratings).group("videos.name").where("video_ratings.rating_id = ?", 5).count
#       => {"Sugar Daddy"=>4,
#           "fantastic beasts and where to find them"=>1,
#           "name"=>5,
#           "wig in a box"=>1}

#    Video.joins(:video_ratings).group("videos.name").where("video_ratings.rating_id = ?", 5).count.sort_by{|k, v| v}.reverse
#        => [["name", 5],
#         ["Sugar Daddy", 4],
#         ["wig in a box", 1],
#         ["fantastic beasts and where to find them", 1]]

  end

end
