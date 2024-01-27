# frozen_string_literal: true

module Posts
  class Destroy < BaseService
    def initialize(post:)
      @post = post
    end

    def self.call(post:)
      new(post:).call
    end

    def call
      if @post.destroy
        success_result(@post)
      else
        failure_result(@post)
      end
    end
  end
end
