class CommentsController < ApplicationController
    before_action :find_post
    
    
    
    private
    def find_post
        @post = Post.find(params[:id])
    end

end
