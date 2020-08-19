class CommentsController < ApplicationController
    before_action :find_post, only: [:new, :create, :destroy]
    before_action :find_comment, only: [:destroy]

    def index 
      @comments = @post.comment.order(created_at: :desc)
    end 
    
    def new 
        @comment = Comment.new

    end
    
    def show 
    end 

    def create

        @comments = @post.comments.new(comment_params)
        @comments.user = current_user
        
        if @comments.save
            redirect_to @post
        else
          flash[:error] = @comment.errors.full_messages
            redirect_to @post
        end
    end

    def destroy 
        # byebug
        if @comment.user == current_user
            @comment.destroy 
            redirect_to @post
        else
            flash[:error] = @comment.errors.full_messages
        end
    end
    
    private

    def comment_params
        params.require(:comment).permit(:body)
    end

    def find_post
        @post = Post.find(params[:post_id])
    end

    def find_comment 
        @comment = Comment.find(params[:id])
    end

end