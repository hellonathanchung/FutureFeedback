class User < ApplicationRecord
  attr_reader :gravatar_url

  has_many :posts
  has_many :comments
  has_many :votes
  acts_as_voter

  validates_uniqueness_of :username

  before_validation :set_default_username
  after_validation :set_default_role
  after_save :set_gravatar_url
  after_find :set_gravatar_url

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :recoverable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  enum role: [ :user, :moderator, :admin ] # creates Devise roles

  def guest?
    persisted?
  end

  #Data aggregation methods
  def num_resolved
    self.posts.map(&:resolved?).count
  end

  def num_upvotes
    self.comments.map(&:upvotes).flatten.count
  end
  
  def num_downvotes
    self.comments.map(&:downvotes).flatten.count
  end

  private

  def set_default_role
    self.role ||= :user
  end

  def set_default_username
    self.username ||= self.create_random_username
  end

  def create_random_username
    username = Faker::Ancient.titan
    username << '_' + SecureRandom.alphanumeric
    
    until !User.find_by(username: username) do
      username = username.split('_')[0]
      username << '_'
      username << '_' + SecureRandom.alphanumeric
    end

    username
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
