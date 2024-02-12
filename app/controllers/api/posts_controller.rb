# frozen_string_literal: true

module Api
  class PostsController < ApplicationController
    def index
      render json: PostSerializer.render(Post.all)
    end

    def show
      post = Post.find(params[:id])
      render json: PostSerializer.render(post)
    end
  end
end
