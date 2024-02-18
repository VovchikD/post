# frozen_string_literal: true

module Api
  class LikesController < Api::ApplicationController
    def create
      result = Likes::Create.call(user: current_user, like_params: like_params)
      if result[:status] == :success
        render json: LikeSerializer.render(result[:record])
      else
        render json: { errors: result[:record].errors.full_messages }
      end
    end

    def destroy
      @like = current_user.likes.find(params[:id])
      result = Likes::Destroy.call(like: @like)

      if result[:status] == :success
        head :no_content
      else
        render json: { errors: 'Like not found' }
      end
    end

    private

    def like_params
      params.require(:like).permit(:target_id, :target_type)
    end
  end
end
