# frozen_string_literal: true

module Comments
  class Create < BaseService
    def initialize(user:, post:, comment_params:)
      @user = user
      @post = post
      @comment_params = comment_params
    end

    def self.call(user:, post:, comment_params:)
      new(user:, post:, comment_params:).call
    end

    def call
      @comment = @post.comments.build(@comment_params.merge(user: @user))
      if @comment.save
        CommentMailer.new_comment(author, @comment).deliver_later unless author == @comment.user
        success_result(@comment)
      else
        failure_result(@comment)
      end
    end

    private

    def author
      @author ||= @post.user
    end
  end
end
