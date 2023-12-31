# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(likes_params)
    if @like.save
      redirect_after_like(@like)
    else
      flash[:alert] = @like.errors.full_messages
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    if @like.destroy
      redirect_after_like(@like)
    else
      flash[:alert] = 'Like not found'
    end
  end

  private

  def likes_params
    params.require(:like).permit(:target_id, :target_type)
  end

  def redirect_after_like(like)
    if like.target_type == 'Comment'
      redirect_to @like.target.post
    elsif like.target_type == 'Post'
      redirect_to post_path(like.target)
    end
  end
end
