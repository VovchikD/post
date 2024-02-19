# frozen_string_literal: true

class LikesController < BaseController
  before_action :find_like, only: [:destroy]

  def create
    result = Likes::Create.call(user: current_user, like_params: like_params)
    if result[:status] == :success
      redirect_after_like(result[:record])
    else
      flash[:alert] = @like.errors.full_messages
    end
  end

  def destroy
    result = Likes::Destroy.call(like: @like)

    if result[:status] == :success
      redirect_after_like(result[:record])
    else
      flash[:alert] = 'Like not found'
    end
  end

  private

  def like_params
    params.require(:like).permit(:target_id, :target_type)
  end

  def redirect_after_like(like)
    if like.target_type == 'Comment'
      redirect_to like.target.post
    elsif like.target_type == 'Post'
      redirect_to post_path(like.target)
    end
  end

  def find_like
    @like ||= current_user.likes.find(params[:id])
  end
end
