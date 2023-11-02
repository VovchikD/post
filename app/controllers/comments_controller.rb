# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    if @comment.save  
      author = @comment.post.user_id
      unless author == @comment.user_id
        CommentMailer.new_comment(author, @comment).deliver_now
      end
      redirect_to @post
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

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
