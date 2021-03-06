class User < ApplicationRecord
  attr_reader :gravatar_url

  has_many :posts, dependent: :nullify
  has_many :comments
  has_many :votes
  acts_as_voter

  validates_uniqueness_of :username

  before_validation :set_default_username, :sanitize_username
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

  #Filter and sort class methods
  def self.all_includes
    User.all
  end

  def self.search_includes(query)
    Post.where('title LIKE :query', query: "%#{query}%")
  end

  def self.filter_with(users, filter)
    users.reject { |user| user.role != filter }
  end

  def self.sort_num_desc(users, key)
    key += '_index'

    users.sort { |b, a| a.try(key) <=> b.try(key) }
  end

  def posts_index
    self.posts.count
  end

  def comments_index
    self.comments.count
  end

  def commented_index
    self.posts.map(&:comments_index).sum
  end

  private

  def set_default_role
    self.role ||= :user
  end

  def set_default_username
    self.username ||= self.class.create_random_username
  end

  def self.create_random_username
    username = self.generate_username_words

    username += '-1'
    append = 1
    until !User.find_by(username: username) do
      append += 1
      len = username.length - 1
      username = username.chars
      username[len] = append.to_s
      username = username.join('')
    end

    username.downcase
  end

  def self.generate_username_words
    username = Faker::Games::DnD.language.gsub(/ /, '-').downcase
    username += '-' + Faker::Ancient.titan.downcase
    username += '-' + Faker::Hipster.word

    username
  end

  def sanitize_username
    self.username = self.username.downcase
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
