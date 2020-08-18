class AdminPolicy < Struct.new(:user, :admin)
  def index?
    user.admin?
  end
  
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
