class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  before_save { self.email = email.downcase }
  validates :first_name, :last_name, presence: true

  has_many :experiences
  has_many :reviews
  has_many :reservations
  

  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.name       = auth.info.name
          user.first_name = user.name.partition(" ").first
          user.last_name  = user.name.partition(" ").last
          user.provider   = auth.provider
          user.uid        = auth.uid
  # Need to update Twitters' settings so  I can retrieve guest's email
          user.email      = auth.info.email
   #       user.email      = "test@test.com"
          user.image      = auth.info.image
          user.password   = Devise.friendly_token[0,20]
          user.save!
      end
    end
  end

  #after_create :send_welcome_mail
  #def send_welcome_mail
  #  UserMailer.welcome(self).deliver_now
  #end

end
