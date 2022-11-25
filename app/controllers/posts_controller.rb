class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:index] # :authenticate_user! usage for all actions wrote in base controller *
  before_action :user_abilities, only: [:edit, :update, :destroy]

  def index
    @post = Post.all.order("created_at DESC")
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    find_post
  end

  def edit
  end

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
    params.require(:post).permit(:title, :content)
  end

  # protection *
  def authenticate_user!
    redirect_to user_session_path unless current_user
  end

  # protection *
  def user_abilities
    redirect_to root_path if @post.user_id != current_user.id
  end
end
