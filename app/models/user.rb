class User < ActiveRecord::Base
  has_secure_password

  has_many :pledges, dependent: :nullify
  has_many :campaigns, dependent: :nullify

  validates :first_name, presence: true
  validates :last_name, presence: true, unless: :with_oauth?

  # This validates email only if the account is not created via oauth - when with_oauth? returns true
  validates :email, presence: true, uniqueness: true, unless: :with_oauth?

  before_create :generate_api_key

  # Ensures that the data passed into twitter_raw_data is a hash
  # There is no data type in the database to store hashes
  # Data-type: OmniAuth::AuthHash < Hashie::Mash
  serialize :twitter_raw_data, Hash

  geocoded_by :address
  after_validation :geocode

  def with_oauth?
    provider.present? && uid.present?
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  # This needs to be a public method because it's being accessed by the CallbacksController
  def self.find_or_create_with_twitter(omniauth_data)
    # .where returns an ActiveRecord object (an array-like object)
    # We only want to select the user returned,
    user = User.where(provider: "twitter", uid: omniauth_data["uid"]).first

    unless user
      full_name = omniauth_data["info"]["name"]
      # rindex returns the index of the last occurence of the given character
      # i.e. "Yii Van Tay" -> "Yii Van " (-1 takes away the final space)
      user = User.create( first_name:        extract_first_name(full_name),
                          last_name:         extract_last_name(full_name),
                          provider:          "twitter",
                          uid:               omniauth_data["uid"],
                          password:          SecureRandom.hex(16),
                          twitter_token:     omniauth_data["credentials"]["token"],
                          twitter_secret:    omniauth_data["credentials"]["secret"],
                          twitter_raw_data:  omniauth_data)
    end

    user
  end

  private

  def generate_api_key
    begin
      # Without self, api_key would be setting a local variable as opposed to accessing the setter method, api_key
      self.api_key = SecureRandom.hex(32)
    end while User.exists?(api_key: self.api_key)
  end

  def self.extract_first_name(full_name)
    # If there is a space in the name, then grab all the words before the last word as the first name
    if full_name.rindex(" ")
      full_name[0..full_name.rindex(" ")-1]
    else
      full_name.split.first # else, set the name as first name
    end
  end

  def self.extract_last_name(full_name)
    # If there is a space in the name, use the last word as the last name
    if full_name.rindex(" ")
      full_name.split.last
    else
      "" # else, set the last name as empty
    end
  end

end
