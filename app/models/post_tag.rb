class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  validates_uniqueness_of :tag_id, { scope: :post_id }
end
