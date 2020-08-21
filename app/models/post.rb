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

  # Sort and filter class methods
  def self.all_includes
    Post.includes(:user, :tags, :comments).all
  end

  def self.search_includes(query)
    Post.includes(:user, :tags, :comments).where('title LIKE :query', query: "%#{query}%")
  end

  def self.filter_with(posts, filter)
    posts.reject { |post| post.status != filter }
  end

  def self.sort_num_desc(posts, key)
    key += '_index'

    posts.sort { |b, a| a.try(key) <=> b.try(key) }
  end
  
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

  # Helper methods for filtering
  def upvotes_index
    self.get_upvotes.count
  end

  def downvotes_index
    self.get_downvotes.count
  end

  def comments_index
    self.comments.count
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

