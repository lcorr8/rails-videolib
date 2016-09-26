class Video < ActiveRecord::Base
  belongs_to :section
  belongs_to :user
  has_many :notes
end
