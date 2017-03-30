class UserSerializer < ActiveModel::Serializer
  attributes :id

  #has_many :watched_videos
  #has_many :videos, through: :watched_videos
end
