# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show destroy]

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc), items: 10)
  end

  def show
    @comment_pagy, @comments = pagy(@post.comments.where(parent_id: nil), items: 5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))
    authorize @post
    if @post.save
      redirect_to root_url
    else
      render :new
    end
  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to root_url
  end

  private

  def find_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
