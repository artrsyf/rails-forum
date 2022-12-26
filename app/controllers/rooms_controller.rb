class RoomsController < ApplicationController
  before_action :main_room_params, only: [:index, :show]
  before_action :find_existing_room, only: :create

  def index
    render 'index'
  end

  def show
    @single_room = Room.find(params[:id])
    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    @room_users = ActiveSupport::JSON.decode(@single_room.room_users)
    @inactive_user_name = @room_users['user1']
    @inactive_user_name = @room_users['user2'] if @inactive_user_name == current_user.name
    @inactive_user = User.find_by(name: @inactive_user_name)
    @inactive_user_last_seen = @inactive_user.last_seen
    render 'index'
  end

  def create
    if @existing_room
      redirect_to @existing_room
    else
      @new_room = Room.new(name: 'dual_room', room_users: @dual_users.to_json)
      if @new_room.save
        redirect_to @new_room
      else
        raise 'Error. Room broken'
      end
    end
  end

  private

  def find_existing_room
    @inactive_user_id = params[:inactive_user_id]
    @dual_users = { user1: current_user.name, user2: User.find_by(id: @inactive_user_id).name }
    @dual_users_reverse = { user1: User.find_by(id: @inactive_user_id).name, user2: current_user.name }
    @room_member_situations = [@dual_users, @dual_users_reverse]
    @room_member_situations.each do |occasion|
      @possible_room = Room.find_by(name: 'dual_room', room_users: occasion.to_json)
      @existing_room = @possible_room unless @possible_room.nil?
    end 
  end

  def main_room_params
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end
end
