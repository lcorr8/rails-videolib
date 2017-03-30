class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :year, :section_id, :flatiron
  belongs_to :section

  #has_many :watched_videos
  has_many :users, through: :watched_videos
  
end
