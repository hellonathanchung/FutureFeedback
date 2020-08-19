class PostsController < ApplicationController
    
before_action :find_post, except: [:index, :new, :create]

  def index
    @posts = Post.includes(:user, :tags).all
  end
  
    def show
        
        @comment = @post.comments.new

    end

    def new
        @post = Post.new
        @comment = Comment.new(post_id: @post.id)

    end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
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
      redirect_to @posts_path
    else
      flash[:error] = @post.errors.full_messages
      redirect_to @posts_path
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
    params.require(:post).permit(:title, :content, :tags)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end