class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(body: msg_params[:body], room_id: params[:room_id])
  end

  # def create_repost_message
  #   @sharing_rooms_id = params[:recipients]
  #   @sharing_rooms_id.each do |room_id|
  #     @message = current_user.messages.create(user_id: current_user.id, room_id: room_id, body: params[:message], repost_id: params[:repost_id])
  #   end
  # end

  private

  def msg_params
    params.require(:message).permit(:body)
  end
end
