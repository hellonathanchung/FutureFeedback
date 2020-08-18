class AdminController < ApplicationController
  # before_action :authorize_admin

  def index
    authorize :admin, :index?
    @posts = Post.all.includes(:users)
    @admin_mods = User.where(role: :admin, role: :moderator).includes(:votes)
  end

  private

  def authorize_admin
    redirect_to root_path unless current_user.admin?
  end
end
