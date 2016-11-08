class User < ApplicationRecord
  mount_uploader :profile_picture, ProfilePictureUploader

  before_save { self.email = email.downcase if self.email}
  before_save :set_invitation_code

  after_create :create_stripe_customer
  after_save :check_stripe_customer
  
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
  validates :phone, presence: true
  validates :password, length: { minimum: 6 }, :if => :password
  validates :invitation_code, :uniqueness => true
    
  validates_confirmation_of :password

  has_secure_password

  has_many :addresses

  attr_accessor :remember_token

  def check_stripe_customer
    unless stripe_id 
      create_stripe_customer
    end
  end

  def create_stripe_customer
    Stripe.api_key =  Rails.application.secrets.stripe_api_key
    @customer = Stripe::Customer.create(
      :description => name,
      :email => email,
      :metadata => {
      	:user_id => id
      }
    )
    update_attribute(:stripe_id, @customer.id)
  end

  def shown_addresses
    addresses.where(:status => :online)
  end
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.remote_profile_picture_url = auth.info.image
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      pass = SecureRandom.uuid
      user.password = pass
      user.password_confirmation = pass
      user.save
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def generate_invitation_code
    [*('a'..'z'),*('0'..'9')].shuffle[0,4].join
  end

  def set_invitation_code
    if self.invitation_code.blank?
      loop do
        @code = generate_invitation_code.upcase
        break if User.where(invitation_code: @code).count == 0
      end
      self.invitation_code = @code
    end
  end
end
