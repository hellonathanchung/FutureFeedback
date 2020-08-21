class PostsController < ApplicationController
  before_action :find_post, except: [ :index, :new, :create ]

  def index
    if !!params[:search]
      @posts = Post.includes(:user, :tags).where('title LIKE :query', query: "%#{params[:search]}%").sort_by(&:created_at).reverse
    else
      @posts = Post.includes(:user, :tags).all.sort_by(&:created_at).reverse
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(title: post_params[:title], content: post_params[:content], user_id: current_user.id)

    if @post.save
      @post.tag_ids = post_params[:tag_ids]
      @post.save
      flash[:success] = "Post successfully created"
      redirect_to @post
    else
      flash[:error] = @post.errors.full_messages
      render 'new'
    end
  end

  def update
    if @post.update_attributes(post_params)
      flash[:success] = "Post was successfully updated"
      redirect_to @post
    else
      flash[:error] = @post.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      flash[:success] = "Post was successfully deleted"
      redirect_to posts_path
    else
      flash[:error] = @post.errors.full_messages
      redirect_to posts_path
    end
  end
  
  def liked_by_user
    @post.upvote_by current_user
    redirect_to :post
  end  

  def disliked_by_user
    @post.downvote_by current_user
    redirect_to :post
  end

  def remove_tag
    PostTag.find_by(post_id: @post.id, tag_id: params[:tag_id]).destroy
    redirect_to @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :search, tag_ids: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
