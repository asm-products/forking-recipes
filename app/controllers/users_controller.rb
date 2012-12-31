class UsersController < ApplicationController
  def show
    @user = User.find(params[:username])
    @recipes = Recipe.where(:user_id => @user.id)
  end
end
