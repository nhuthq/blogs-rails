class CommentsController < ApplicationController

  # before_action :authenticate_user!, except: %i[index show]
  # before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def edit
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    redirect_to post_path(@post), notice: "Comment was successfully create."
  end

  def destroy

  end

  private

  def set_comment
    @post = Post.find(params[:post_id])
    redirect_to posts_path, notice: 'Can not find thr correct Post' if @post.nil?
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :content, :post_id)
  end
end
