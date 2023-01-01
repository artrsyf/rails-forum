class RepostsController < ApplicationController
  def create
    @profile = Profile.find_by(user_id: current_user.id)
    @post_index = params[:post_index]
    if @profile.reposts.create(repost_id: @post_index, location: params[:repost_location], message: params[:repost_text])
      redirect_to posts_repost_url
    else
      raise 'Error, cant repost'
    end
  end

  def destroy; end
end
