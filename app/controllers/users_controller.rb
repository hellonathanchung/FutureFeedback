class UsersController < ApplicationController
  def show
    @user = User.find(params[:user_slug])
  end
end
