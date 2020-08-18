class UsersController < ApplicationController
  before_action :draw_user, only: [ :show ]
  before_action :set_current_user, only: [ :edit, :update ]

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
    render :edit
  end

  def update
    if @user.update(user_params)
      # success, redirect
      flash[:success] = 'User profile updated!'
      redirect_to user_path(@user.username)
    else
      # failure
      # flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def draw_user
    @user = User.find_by(username: params[:username])
  end

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :username)
  end
end
