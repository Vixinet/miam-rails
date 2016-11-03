class User < ApplicationRecord
	before_save { self.email = email.downcase }
	before_save :set_invitation_code
	
	validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }, :if => :password
	validates :invitation_code, :uniqueness => true
  	
  	validates_confirmation_of :password

	has_secure_password

	attr_accessor :remember_token

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
				@code = generate_invitation_code
				puts @code
				break if User.where(invitation_code: @code).count == 0
			end
			self.invitation_code = @code
		end
	end
end
