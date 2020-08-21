class Post < ApplicationRecord
  has_rich_text :content
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

  # Display methods
  def written_date
    self.created_at.strftime(" on %m/%d/%Y")
  end

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

  def count_upvotes
    self.get_upvotes.count
  end

  def count_downvotes
    self.get_downvotes.count
  end

  # Setter methods for forms
  def tag_ids=(tag_id_list)
    tag_id_list.each { |tag_id| PostTag.create(post_id: self.id, tag_id: tag_id) if !tag_id.blank? }
  end

  private

  def set_default_status
    self.status ||= :open
  end
end

