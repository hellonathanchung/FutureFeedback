class WelcomeController < ApplicationController
  def index
    if !!current_user
      redirect_to '/posts'
    else
      redirect_to '/login'
    end
  end
end
