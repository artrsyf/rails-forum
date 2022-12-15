class ProfilesController < ApplicationController
  def show
    @user_nickname = current_user.name
    @user_email = current_user.email
    @user_posts = current_user.posts
    @user_reposts = []
    @user_reposts_reference = Profile.find_by(user_id: current_user.id).reposts
    @user_reposts_reference.each do |repost_reference|
      repost_id = repost_reference.repost_id
      reposted_post = Post.find_by(id: repost_id)
      reposted_post.created_at = repost_reference.created_at
      reposted_post.updated_at = repost_reference.updated_at
      @user_reposts.push(reposted_post)
    end
    @user_content = (@user_posts + @user_reposts).sort_by { |element| element.updated_at }.reverse
  end

  def new_repost
  end
end
