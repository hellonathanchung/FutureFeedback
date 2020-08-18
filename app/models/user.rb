class User < ApplicationRecord
  attr_reader :gravatar_url
  
  after_validation :set_default_role, :set_gravatar_url
  after_find :set_gravatar_url

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :user, :moderator, :administrator ] # creates Devise roles

  def guest?
    persisted?
  end

  private

  def set_default_role
    self.role ||= :user
  end

  def set_gravatar_url
    self.gravatar_url = "https://www.gravatar.com/avatar/#{self.gravatar_email_hash}?d=retro"
  end

  def gravatar_url=(url)
    @gravatar_url = url
  end

  def gravatar_email_hash
    Digest::MD5.hexdigest self.email.strip.downcase
  end
end
