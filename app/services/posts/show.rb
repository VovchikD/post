# frozen_string_literal: true

module Posts
  class Show
    def initialize(post:, user:)
      @post = post
      @user = user
    end

    def self.call(post:, user:)
      new(post:, user:).call
    end

    def call
      update_comments_seen if @user == @post.user
      { status: :success, record: @post }
    end

    private

    def update_comments_seen
      @post.comments.update_all(seen: true)
    end
  end
end
