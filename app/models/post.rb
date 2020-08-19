class Post < ApplicationRecord
  acts_as_votable
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :post_tags
  has_many :tags, through: :post_tags
  
  before_validation :set_default_status
  
  validates :title, presence: true
  validates :content, presence: true
  validates :status, presence: true
  
  enum status: [ :open, :pending, :resolved, :closed ] # Set statuses as symbols/integer in db

  # Status question methods
  def open?
    self.status == :open
  end

  def pending?
    self.status == :pending
  end

  def resolved?
    self.status == :resolved
  end

  def closed?
    self.status == :closed
  end
end

private 
def set_default_status
  self.status ||= :open
end