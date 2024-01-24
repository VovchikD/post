# frozen_string_literal: true

module Posts
  class Destroy
    def initialize(post:)
      @post = post
    end

    def self.call(post:)
      new(post:).call
    end

    def call
      if @post.destroy
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
