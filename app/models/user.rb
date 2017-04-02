class User < ActiveRecord::Base
  enum role: [:general_student, :flatiron_student, :admin]
  after_initialize :set_default_role, :if => :new_record?

  has_many :watched_videos
  has_many :videos, through: :watched_videos
  has_many :video_ratings
  has_many :videos, through: :video_ratings
  has_many :notes


  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:github]

#used in the github method called by omniauth callback controller
  def self.from_omniauth(auth)
      where(email: auth.info.email).first_or_create! do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      #use the github username to link to learn.co profiles
      user.username = auth.info.nickname
      #add image to show the github/learn avatar
      #user.image_link = auth.info.image
      user.role = 0

      #cant get devise password to save from the getgo 
      user.password= Devise.friendly_token[0,20]
    end      
  end

  def set_default_role
    self.role ||= :general_student
  end

  def user_role
    if self.role == "general_student"
      "General Student"
    elsif self.role == "flatiron_student"
      "Flatiron Student"
    elsif self.role == "admin"
      "Admin"
    end
  end

end #class