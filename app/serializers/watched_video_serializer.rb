class WatchedVideoSerializer < ActiveModel::Serializer
  attributes :id, :video_id, :user_id, :watched

   #belongs_to :video
   #belongs_to :user
end
