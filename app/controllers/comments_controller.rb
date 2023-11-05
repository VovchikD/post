# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post, only: [:create]

  def create
    @comment = @post.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      author = @comment.post.user
      CommentMailer.new_comment(author, @comment).deliver_later unless author == @comment.user
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path
  end

  private

  def find_post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
