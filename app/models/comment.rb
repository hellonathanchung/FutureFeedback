class Comment < ApplicationRecord
  belongs_to :user
  # belongs_to :post
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  
  validates :body, :presence => true,
  :length => {:within => 3..200}

end
