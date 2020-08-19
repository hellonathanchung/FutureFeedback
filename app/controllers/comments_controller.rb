class CommentsController < ApplicationController
    before_action :find_post, only: [:destroy]
    before_action :find_comment, only: [:destroy]
    before_action :find_commentable, only: [:create]

    def index 
      @comments = @post.comment.order(created_at: :desc)
    end 
    
    def new 
        @comment = Comment.new

    end
    
    def show 
    end 

    def create

        # @comments = @post.comments.new(comment_params)
        # @comments.user = current_user
        
        # if @comments.save
        #     redirect_to @post
        # else
        #   flash[:error] = @comment.errors.full_messages
        #     redirect_to @post
        # end

        # @comments = @commentable.comments.new(comment_params)
        # byebug
        @comment = @commentable.comments.build(comment_params)
        # byebug
        @comment.user = current_user
        # byebug
            if @comment.save
                redirect_to @post, notice: 'Your comment was successfully posted!'
            else
                redirect_to @post, notice: "Your comment wasn't posted!"
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

    def find_commentable
        if params[:comment_id]
            @commentable = find_comment 
        elsif params[:post_id]
            @commentable = find_post
        end
      end

end