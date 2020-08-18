class User < ApplicationRecord
  after_validation :set_default_role

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [ :user, :moderator, :administrator ] # creates Devise roles

  def guest?
    persisted?
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
