module UsersHelper
  def user_follow_path(user)
    "/#{user.username}/follow"
  end

  def user_unfollow_path(user)
    "/#{user.username}/unfollow"
  end
end
