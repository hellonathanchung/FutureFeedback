class AdminController < ApplicationController
  before_action :authorize_admin

  def index
    authorize :admin, :index?
    @posts = Post.all.includes(:user)
    @admin_mods = User.where(role: :admin, role: :moderator).includes(:votes)
  end

  private

  def authorize_admin
    user_not_authorized unless current_user.admin?
  end
end
