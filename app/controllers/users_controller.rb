class UsersController < ApplicationController
  include UsersHelper

  before_filter :authenticate_user!, :except => [:show]

  def show
    @user    = User.find_by_username(params[:username])
    return render :inline => "We couldn't find that user in our system :(" unless @user
    @recipes = Recipe.where(:user_id => @user.id)

    if @user == current_user
      recipe_ids = Recipe.connection.select_values("select voteable_id from votings where voter_id = #{@user.id}")
      @favorited_recipes = Recipe.find_all_by_id(recipe_ids)
    end
  end

  def follow
    current_user.follow!(User.find_by_username(params[:username])) if current_user

    redirect_to :back
  end

  def unfollow
    current_user.unfollow!(User.find_by_username(params[:username])) if current_user

    redirect_to :back
  end
end
