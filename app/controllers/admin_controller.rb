class AdminController < ApplicationController
  def index
    @posts = Post.all.includes(:users)
    @admin_mods = User.where(role: :admin, role: :moderator).includes(:votes)
  end
end
