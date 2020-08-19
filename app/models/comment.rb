class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  validates :body, :presence => true,
  :length => {:within => 6..200}
end
