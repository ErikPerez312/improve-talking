class User < ApplicationRecord
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  # 1. Hash password before saving a User
  before_save :encrypt_password
  # 2. Generate a token for authentication before creating a User
  before_create :generate_token
  # 3. Adds a virtual password field, which we will use when creating a user
  attribute :password, :string

  def self.authenticate(username, password)
    user = self.find_by_username(username)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      return user
    else
      return nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # Generates a token for a user
  def generate_token
    token_gen = SecureRandom.hex
    self.token = token_gen
    token_gen
  end
end
