# frozen_string_literal: true

module Posts
  class Create < BaseService
    def initialize(user:, post_params:)
      super()
      @user = user
      @post_params = post_params
    end

    def self.call(user:, post_params:)
      new(user:, post_params:).call
    end

    def call
      @post = @user.posts.build(@post_params)

      if @post.save
        success_result(@post)
      else
        failure_result(@post)
      end
    end
  end
end
