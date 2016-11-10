class Video < ActiveRecord::Base
  belongs_to :section
  #belongs_to :user
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
  #validates :watched, presence: true
  validates :section_id, presence: true #from existing ones?

  #scope :hardest_videos, -> {where(ratings: 5)} #look at how to scope the joins table for this?
  #^ videos with a rating of 4 + 5 to study again

  scope :sixteen, -> { where( year: "2016" ) }
  scope :fifteen, -> { where( year: "2015" ) }
  scope :fourteen, -> { where( year: "2014" ) }
  scope :not_watched, -> { where(watched: "no" ) }
  
  def section=(section)
      section = Section.find_or_create_by(name: section[:name])
      self.section_id = section.id
  end

  

end
