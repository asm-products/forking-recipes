module UsersHelper
  def user_follow_path(user)
    follow_user_path(user)
  end

  def user_unfollow_path(user)
    unfollow_user_path(user)
  end
end
