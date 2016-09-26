class Video < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :notes

  validates :name, presence: true
  validates :link , presence: true, uniqueness: true
  validates :year, presence: true
  #works for only LV videos, if user wants to add another resource video this validation
  #becomes useless by limiting them to 3 years
  #, :inclusion => { :in => %w(2014 2015 2016), :message => "%{value} is not a valid cohort year for LV" } 
  validates :watched, presence: true
  validates :section_id, presence: true #from existing ones?

end