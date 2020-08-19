class UsersController < ApplicationController
  before_action :draw_user, only: [ :show, :edit ]
  # before_action :set_current_user, only: [ :update ]

  def index
    authorize User
    if !!params[:search]
      @users = User.where('username LIKE :query', query: "%#{params[:search]}%")
    else
      @users = User.all.sort_by(&:username).reverse
    end
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
    render :edit
  end

  def update
    @user = User.find(user_params[:id])
    if @user.update(user_params)
      # success, redirect
      flash[:success] = 'User profile updated!'
      redirect_to user_path(@user.username)
    else
      # failure, error messages handled in the form view
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
    params.require(:user).permit(:id, :first_name, :last_name, :email, :username, :search)
  end
end
