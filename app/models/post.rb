class Post < ApplicationRecord
  belongs_to :user
  has_many :comments 
  has_many :post_tags
  has_many :tags, through: :post_tags

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
