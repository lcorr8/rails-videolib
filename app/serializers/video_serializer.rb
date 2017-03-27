class VideoSerializer < ActiveModel::Serializer
  attributes :id, :name, :link, :year, :section_id, :flatiron
  belongs_to :section
end
