class RepostsController < ApplicationController
  def create
    @profile = Profile.find_or_create_by(user_id: current_user.id)
    @post_index = params[:post_index]
    print 'params is '
    print @post_index
    @profile.reposts.create(repost_id: @post_index)
  end

  def destroy; end
end
