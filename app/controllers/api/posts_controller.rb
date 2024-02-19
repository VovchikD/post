# frozen_string_literal: true

module Api
  class PostsController < Api::BaseController
    def index
      render json: PostSerializer.render(Post.all)
    end

    def show
      post = Post.find(params[:id])
      render json: PostSerializer.render(post)
    end

    def create
      result = Posts::Create.call(user: current_user, post_params: post_params)

      if result[:status] == :success
        render json: PostSerializer.render(result[:record])
      else
        render json: { errors: result[:record] }
      end
    end

    def destroy
      @post = Post.find(params[:id])
      authorize @post
      result = Posts::Destroy.call(post: @post)
      if result[:status] == :success
        head :no_content
      else
        render json: { errors: result[:record] }
      end
    end

    private

    def post_params
      params.require(:post).permit(:title, :body)
    end
  end
end
