# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def create
    result = Comments::Create.call(user: current_user, post: @post, comment_params: comment_params)

    if result[:status] == :success
      redirect_to post_path(@post)
    else
      @comment = result[:record]
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment

    result = Comments::Destroy.call(comment: @comment)
    if result[:status] == :success
      redirect_to post_path
    else
      @comment = result[:record]
    end
  end

  private

  def find_post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
