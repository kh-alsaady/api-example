class User < ActiveRecord::Base
  # callbacks 
  before_create :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Validations
  validates :password, :password_confirmation, presence: true
  #validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: 'Invalid Email Address'}

  private

  def ensure_authentication_token
  	self.authentication_token = generate_token 
  end

  # Generate random unique token
  def generate_token
  	loop do 
  		token = SecureRandom.hex
  		break token unless User.exists? authentication_token: token
  	end
  end

end
