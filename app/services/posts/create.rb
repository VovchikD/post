# frozen_string_literal: true

module Posts
  class Create
    def initialize(user:, post_params:)
      @user = user
      @post_params = post_params
    end

    def self.call(user:, post_params:)
      new(user:, post_params:).call
    end

    def call
      @post = @user.posts.build(@post_params)

      if @post.save
        success_result
      else
        failure_result
      end
    end

    private

    def success_result
      { status: :success, record: @post }
    end

    def failure_result
      { status: :failure, record: @post }
    end
  end
end
