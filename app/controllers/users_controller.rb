class UsersController < ApplicationController
  def show
    @user = User.find_by_username(params[:username])
    @recipes = Recipe.where(:user_id => @user.id)
  end
end
