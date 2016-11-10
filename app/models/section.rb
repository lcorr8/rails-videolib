class Section < ActiveRecord::Base
  #belongs_to :user
  has_many :videos

  validates :name, presence: true, uniqueness: true

end

