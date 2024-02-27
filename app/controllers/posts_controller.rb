class PostsController < ApplicationController

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_post, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def show
  end

  def edit
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_url, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy!
    respond_to do |format|
      format.html { redirect_to posts_url(@post), notice: "Post was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to posts_path, notice: 'You are not authorized to edit this post' if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :short_description, :content, :published, :published_at)
  end

end
