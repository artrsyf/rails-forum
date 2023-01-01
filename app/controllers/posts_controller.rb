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
    render 'posts/repost', locals: { is_open: params[:is_open], post_index: params[:post_id] }
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
end
