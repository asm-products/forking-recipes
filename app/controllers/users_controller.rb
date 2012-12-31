class UsersController < ApplicationController
  def show
    user_id = User.select(:id).find(params[:username])
    @recipes = Recipe.where(:user_id => user_id)
  end
end
