class UsersController < ApplicationController
  #include UsersHelper

  def show
    @user    = User.find_by_username(params[:username])
    @recipes = Recipe.where(:user_id => @user.id)
  end

  def follow
    redirect_to '/'
  end
end
