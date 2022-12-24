class ProfilesController < ApplicationController
  before_action :find_user_profile, only: [:find_user_reposts, :set_profile_content, :show]
  before_action :set_profile_content, only: [:show] 

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(user_id: current_user.id, nick_name: current_user.name)
    if @profile.save
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user_content = (@user_posts + @user_reposts).sort_by { |element| element.updated_at }.reverse
  end

  def edit
    @profile = Profile.find_by(user_id: current_user.id)
  end
  
  def update
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile.update(profile_params)
      redirect_to profile_path
    else
      render 'edit'
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:nick_name)
  end

  def find_user_profile
    @profile = Profile.find_by(user_id: params[:id])
  end

  def find_user_reposts
    user_reposts = []
    if @profile
      @user_reposts_reference = @profile.reposts
      @user_reposts_reference.each do |repost_reference|
        repost_id = repost_reference.repost_id
        if (reposted_post = Post.find_by(id: repost_id))
          reposted_post.created_at = repost_reference.created_at
          reposted_post.updated_at = repost_reference.updated_at
          user_reposts.push(reposted_post)
        else
          raise 'Error, index mismatch'
        end
      end
    end
    user_reposts
  end

  def set_profile_content
    @user_nickname = @profile.nick_name
    @user_email = User.find_by(id: params[:id]).email
    @user_posts = User.find_by(id: params[:id]).posts
    @user_reposts = find_user_reposts
  end
end
