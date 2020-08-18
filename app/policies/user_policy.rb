class UserPolicy < ApplicationPolicy
  def show?
    !user.guest?
  end

  def update?
    (record.id == user.id || user.admin?)
  end

  def edit?
    self.update?
  end

  def create?
    true
  end

  def new?
    self.create?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
