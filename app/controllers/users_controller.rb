class UsersController < ApplicationController
  include UsersHelper

  def show
    @user    = User.find_by_username(params[:username])
    return render :inline => "We couldn't find that user in our system :(" unless @user
    @recipes = Recipe.where(:user_id => @user.id)
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
