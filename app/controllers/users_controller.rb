class UsersController < ApplicationController
  def show
    @user = User.find(params[:username])
  end
end
