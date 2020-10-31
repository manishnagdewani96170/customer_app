class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role 

  scope :role_based_user, ->(role) { includes(:role).where(role_code: role) }  

  before_save :ensure_authentication_token

 
  def generate_password
    self.password = Devise.friendly_token.first(8)
    self.password_confirmation = self.password
  end


  # tells Devise not to validate email presence (for UI check is done in controller)
  def email_required?
    false
  end

  # tells Devise not to validate password presence (for UI check is done in controller)
  def password_required?
    false
  end

  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end


  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).exists?
    end
  end
    
end
