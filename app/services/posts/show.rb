# frozen_string_literal: true

module Posts
  class Show
    include Pagy::Backend

    def initialize(post:, user:, params:)
      @post = post
      @user = user
      @params = params
    end

    def self.call(post:, user:, params:)
      new(post:, user:, params:).call
    end

    def call
      update_comments_seen if @user == @post.user
      { post: @post, comments: paginate_comments }
    end

    private

    def update_comments_seen
      @post.comments.update_all(seen: true)
    end

    def paginate_comments
      pagy(@post.comments.where(parent_id: nil), page: @params.fetch(:page, 1), items: 5)
    end
  end
end
