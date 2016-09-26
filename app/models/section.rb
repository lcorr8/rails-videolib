class Section < ActiveRecord::Base
  belongs_to :user
  has_many :videos

  validates :name, presece: true, uniqueness: true
end
