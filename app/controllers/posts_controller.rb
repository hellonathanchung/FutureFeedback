class PostsController < ApplicationController
    
before_action :find_post, except: [:index, :new, :create]

  def index
    @posts = Post.includes(:user, :tags).all
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

  private

  def post_params
    params.require(:post).permit(:title, :content, tag_ids: [])
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
