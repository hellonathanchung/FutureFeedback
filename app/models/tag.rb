class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, length: { minimum: 1, maximum: 10 }
  validates_uniqueness_of :name
end
