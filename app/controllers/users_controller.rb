class UsersController < ApplicationController
  before_action :draw_user, only: [ :show, :edit ]
  # before_action :set_current_user, only: [ :update ]

  def index
    authorize User

    @users = !!params[:search] ? User.search_includes(params[:search]) : User.all_includes

    @users = User.filter_with(@users, params[:filter]) if !!params[:filter]

    @users = User.sort_num_desc(@users, params[:sort_by]) if !!params[:sort_by]
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
