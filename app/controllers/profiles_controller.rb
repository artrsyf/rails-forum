class ProfilesController < ApplicationController
  def show
    @user_nickname = current_user.name
    @user_email = current_user.email
    @user_posts = current_user.posts
  end

  def new_repost
    @post_index = params[:post_index]
    print 'params is '
    print @post_index
    Profile.create(posted_post_id: @post_index)
  end
end
