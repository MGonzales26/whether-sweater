class User < ApplicationRecord
  include ApiKey
  
  validates :email, 
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP } 
  validates_presence_of :password
  validates_presence_of :password_confirmation
  validates_presence_of :api_key

  has_secure_password

  before_validation :set_api_key

  def set_api_key
    self.api_key = ApiKey.generator
  end
end
