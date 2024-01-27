# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :find_post, only: %i[show destroy]

  def index
    @pagy, @posts = pagy(Post.order(created_at: :desc), items: 10)
  end

  def show
    result = Posts::Show.call(post: @post, user: current_user)
    @post = result[:post]
    @comment_pagy, @comments = pagy(@post.comments.where(parent_id: nil), items: 5)
  end

  def new
    @post = Post.new
  end

  def create
    result = Posts::Create.call(user: current_user, post_params: post_params)

    if result[:status] == :success
      redirect_to root_url
    else
      @post = result[:record]
      render :new
    end
  end

  def destroy
    authorize @post
    result = Posts::Destroy.call(post: @post)
    if result[:status] == :success
      redirect_to root_url
    else
      @post = result[:record]
    end
  end

  private

  def find_post
    @post ||= Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
