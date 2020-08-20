class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable

  validates :body, :presence => true,
  :length => {:within => 3..200}
end
