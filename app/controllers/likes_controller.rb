class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(likes_params)
    if @like.save
      redirect_to @like.target
    else
      puts @like.errors.full_messages
    end
  end

  def destroy
    @like = Like.find(params[:id])
    if @like.destroy
      redirect_to root_path
    else
      flash[:alert] = 'Like not found'
    end
  end

  private

  def likes_params
    params.require(:like).permit(:target_id, :target_type)
  end
end