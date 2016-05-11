class User < ActiveRecord::Base
  has_secure_password

  has_many :pledges, dependent: :nullify
  has_many :campaigns, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  before_save :generate_api_key

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def generate_api_key
    begin
      # Without self, api_key would be setting a local variable as opposed to accessing the setter method, api_key
      self.api_key = SecureRandom.hex(32)
    end while User.exists?(api_key: self.api_key)
  end
end
