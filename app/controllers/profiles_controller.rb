class ProfilesController < ApplicationController
  def show
    @user_nickname = current_user.name
    @user_email = current_user.email
    @user_posts = current_user.posts
  end
end
