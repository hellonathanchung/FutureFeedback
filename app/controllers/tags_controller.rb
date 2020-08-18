class TagsController < ApplicationController
  before_action :draw_tag, only: [ :show, :update, :destroy ]

  def index
    authorize Tag
    if !!params[:search] # TODO: Sanitize this with sanitize_sql_like
      @tags = Tag.includes(:posts).where('name LIKE :query', query: "%#{params[:search]}%")
    else
      @tags = Tag.includes(:posts).all
    end
  end

  def show
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
    @tag = Tag.includes(:posts).find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name, :search)
  end
end
