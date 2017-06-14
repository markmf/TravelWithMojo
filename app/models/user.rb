class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }
  validates :first_name, :last_name, presence: true

  has_many :experiences
  has_many :reviews
  

  #after_create :send_welcome_mail
  #def send_welcome_mail
  #  UserMailer.welcome(self).deliver_now
  #end

end
