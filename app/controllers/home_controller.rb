class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to "/#{current_user.username}" 
    else
      redirect_to :browse
    end
  end

  def browse
    @recipes = Recipe.last(10)
    @users   = User.last(10)

    render :index
  end
end
