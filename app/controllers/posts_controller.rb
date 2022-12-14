class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index] # :authenticate_user! usage for all actions wrote in base controller *
  before_action :user_abilities, only: [:edit, :update, :destroy]
  before_action :check_for_cancel, only: [:edit, :update, :create]

  def index
    @post = Post.all.order("created_at DESC")
    @posted_post = params[:id]
    # think about profile model, mb its not a necessary, there is devise model, then drop db, delete model and db:migrate
  end

  def repost
    @is_open = params[:is_open]
    @post_index = params[:post_id]
    # @chats = current_user_chats
    @chats_id = current_user_chats.map { |current_user_chat| current_user_chat.id }
    @current_user_recipients = []
    @chats_id.each do |chat_id|
      chat_reference = Room.find_by(id: chat_id)
      if chat_reference.name != 'dual_room'
        @current_user_recipients.push({chat_name: chat_reference.name, chat_id: chat_reference.id})
      else
        @current_user_recipients.push({chat_name: find_dual_room_recipient(chat_reference), chat_id: chat_reference.id})
      end
    end
  end

  def upvote
    @post = Post.find_by_id(params[:id])
    if current_user.voted_up_on? @post
      @post.unvote_by current_user
    else
      @post.upvote_by current_user
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    print @post.save
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :avatar)
  end

  # protection *
  def authenticate_user!
    redirect_to user_session_path unless current_user
  end

  # protection *
  def user_abilities
    redirect_to root_path if @post.user_id != current_user.id
  end

  def check_for_cancel
    if params[:commit] == 'Cancel'
      redirect_to :back
    end
  end

  def current_user_chats
    @current_user_profile = Profile.find_by(user_id: current_user.id)
    @room_numbers = []
    Room.all.each do |room_reference|
      @room_numbers.push(room_reference.id) if ActiveSupport::JSON.decode(room_reference.room_users).to_a.map { |user_hash| user_hash[1] }.include?(current_user.name)
    end
    Room.find(@room_numbers)
    #  Room.where(ActiveSupport::JSON.decode(room_users).to_a.map { |user_hash| user_hash[1] }.include?(current_user.name): true)
  end

  def find_dual_room_recipient(chat_reference)
    ActiveSupport::JSON.decode(chat_reference.room_users).to_a.map { |hash_array_element| hash_array_element[1] }.reject { |chat_user| chat_user == current_user.name }[0]
  end
end
