class CommentsController < ApplicationController
    before_action :find_post, only: [:destroy]
    before_action :find_comment, only: [:destroy, :liked_by_user, :disliked_by_user]
    before_action :find_commentable, only: [:create]

  def index
    @comments = @post.comment.order(created_at: :desc)
  end

  def new
  end

  def show
  end 

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    byebug
    @comment.commentable = Post.find(comment_params[:commentable_id])

    notice = @comment.save ? 'Your comment was added!' : "Couldn't post your comment, sorry!"
    redirect_to post_path(comment_params[:commentable_id]), notice: notice
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy 
      redirect_to @post
    else
      flash[:error] = @comment.errors.full_messages
    end
  end
    

  def liked_by_user
    @comment.upvote_by current_user
    redirect_to @comment.commentable
  end  

  def disliked_by_user
    @comment.downvote_by current_user
    redirect_to @comment.commentable
  end
  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :commentable_id)
  end

  def find_post
      @post = Post.find(params[:post_id])
  end

  def find_comment 
    @comment = Comment.find(params[:id])
  end

  def find_commentable
    if params[:comment_id]
      @commentable = find_comment 
    elsif params[:post_id]
      @commentable = find_post
    end
  end
end
