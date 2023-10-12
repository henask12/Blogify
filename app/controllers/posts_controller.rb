class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    # List all post from a user
    @user = User.find_by(id: params[:user_id])
    # All posts from a user and paginate them
    @posts = @user.posts.includes(:author, :likes, :comments).page(params[:page]).per(4)
  end

  def show
    @user = User.find_by(id: params[:user_id])
    # found the post which 'id' is the same as the parameter 'id' on the URL
    @posts = Post.includes(:author, :likes, :comments).find(params[:id])
  end

  def new
    @user = current_user
    @new_post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:notice] = 'Post successfully added!'
      redirect_to user_path(current_user)
    else
      flash[:alert] = 'Post could not be added.'
      redirect_to new_user_post_path(current_user)
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Comment.where(post_id: @post).delete_all if Comment.where(post_id: @post.id).any?
    user = User.find(params[:user_id])
    return unless @post.destroy

    user.update_post_counter
    redirect_to user_path(user)
  end


  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
