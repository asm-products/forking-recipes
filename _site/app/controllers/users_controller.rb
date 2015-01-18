class UsersController < ApplicationController
  include UsersHelper

  before_filter :authenticate_user!, :except => [:show]
  before_filter :get_user

  def show
    @recipes = Recipe.where(:user_id => @user.id)

    if @user == current_user
      @favorited_recipes = current_user.starred_recipes
    end
  end

  def follow
    current_user.follow!(@user) if current_user

    redirect_to :back
  end

  def unfollow
    current_user.unfollow!(@user) if current_user

    redirect_to :back
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :remember_me, :username)
  end

  def get_user
    @user = User.find_by_username(params[:id])
    return render :inline => "We couldn't find that user in our system :(" unless @user
  end
end
