class TagsController < ApplicationController
  before_action :draw_tag, only: [ :edit, :update, :destroy ]

  def index
    authorize Tag
    @tags = Tag.includes(:post_tags).all
  end

  def new
  end

  def create
    @tag = Tag.new(tag_params)

    if @tag.save
      #success, redirect
      flash[:success] = "Created tag: #{@tag.name.titleize}"
      redirect_to tags_path
    else
      #failure, error handling
      flash[:errors] = @tag.errors.full_messages
      redirect_to new_tag_path
    end
  end

  def edit
  end

  def update
    if @tag.upate(tag_params)
      #success, redirect
      flash[:success] = "Updated tag: #{@tag.name.titleize}"
      redirect_to tags_path
    else
      #failure, error handling
      flash[:errors] = @tag.errors.full_messages
      redirect_to edit_path(@tag)
    end
  end

  def destroy
    @tag.destroy
    flash[:success] = "Deleted tag: #{@tag.name.titleize}"
    redirect_to tags_path
  end

  private

  def draw_tag
    byebug
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end
end
