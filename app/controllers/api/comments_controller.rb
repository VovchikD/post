# frozen_string_literal: true

module Api
  class CommentsController < ApplicationController
    def create
      @post = Post.find(params[:post_id])
      result = Comments::Create.call(user: current_user, post: @post, comment_params: comment_params)

      if result[:status] == :success
        render json: CommentSerializer.render(result[:record])
      else
        render json: { errors: result[:record] }
      end
    end

    def destroy
      @comment = Comment.find(params[:id])
      authorize @comment

      result = Comments::Destroy.call(comment: @comment)
      if result[:status] == :success
        head :no_content
      else
        render json: { errors: result[:record] }
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content, :parent_id)
    end
  end
end
