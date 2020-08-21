class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, length: { minimum: 1, maximum: 10 }
  validates_uniqueness_of :name

  before_validation :downcase_name

  # Class helper methods to filter and sort
  def self.all_includes
    @tags = Tag.includes(:posts).all
  end

  def self.search_includes(query)
      @tags = Tag.includes(:posts).where('name LIKE :query', query: "%#{query}%")
  end

  def self.sort_num_desc(tags, key)
    key += '_index'

    tags.sort { |b, a| a.try(key) <=> b.try(key) }
  end

  def posts_index
    self.posts.count
  end

  def popularity_index
    self.posts_index + self.posts.map(&:comments_index).sum
  end

  private

  def downcase_name
    self.name = self.name.downcase
  end
end
