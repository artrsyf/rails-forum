class RepostsController < ApplicationController
  def create
    @profile = Profile.find_by(user_id: current_user.id)
    @post_index = params[:post_index]
    @location = params[:repost_location]
    @recipients = params[:recipients][1..] if @location == 'message_repost' # 1.. we take in care class of checkbox is the first params which gives
    @new_repost = @profile.reposts.new(repost_id: @post_index, location: @location, message: params[:repost_text], recipients: @recipients.to_s)
    if @new_repost.save
      if @location == 'message_repost'
        # redirect_to messages_create_repost_message_path(method: :post, repost_id: @post_index, message: params[:repost_text], recipients: @recipients)
        # cant make post request from this action to create message action
        @recipients.each do |room_id|
          @message = current_user.messages.create(user_id: current_user.id, room_id: room_id, body: params[:repost_text], repost_id: @post_index)
        end
      end
      redirect_to posts_repost_url  
    # else hold on modal page
    end
  end

  def destroy; end
end
