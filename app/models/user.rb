class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable


 has_attached_file :profile_pic, styles: { medium: "500x500>", thumb: "100x100#" }

  validates_attachment :profile_pic,
# styles: { medium: "400x400#", thumb: "200x200#" },
  content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] },
  message: 'Only images (eg, jpeg, gif, png) allowed.'


  before_save { self.email = email.downcase }
  validates :first_name, :last_name, presence: true

  has_many :experiences
  has_many :reviews
  has_many :reservations
  has_many :schedules
  has_many :notifications
  has_many :guests
  has_many :cancellations

  has_one :setting
  after_create :add_setting

  def add_setting
    Setting.create(user: self, enable_sms: true, enable_email: true)
  
  end


  def self.from_omniauth(auth)
    user = User.where(email: auth.info.email).first

    if user
      return user
    else
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          user.name       = auth.info.name
          user.first_name = user.name.partition(" ").first
          user.last_name  = user.name.partition(" ").last
          user.social_provider = auth.provider 
    # Used for Stripe
    #     user.provider   = auth.provider
          user.provider   = auth.provider == "stripe_connect" ? auth.provider :
          user.uid        = auth.uid
  # Need to update Twitters' settings so  I can retrieve guest's email
          user.email      = auth.info.email
   #       user.email      = "test@test.com"
          user.image      = auth.info.image
          user.password   = Devise.friendly_token[0,20]
          logger.debug "AUTHORIZATION #{auth}"
          user.save!
      end
    end
  end

  # Twilio methods
  def generate_pin
    self.pin = SecureRandom.hex(2)
    self.phone_verified = false
    save
  end

  def send_pin
    @client = Twilio::REST::Client.new
    @client.messages.create(
      from: '+18564223781',
      to: self.contact_no,
      body: "Your pin is #{self.pin}"
    )
  end

  def verify_pin(entered_pin)
    update(phone_verified: true) if self.pin == entered_pin
  end

  def is_active_host
     self.provider == "stripe_connect" 
 #   !self.uid.blank?  #check if user has crated a merchant stripe id
  end

  #after_create :send_welcome_mail
  #def send_welcome_mail
  #  UserMailer.welcome(self).deliver_now
  #end

end
