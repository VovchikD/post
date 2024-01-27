# frozen_string_literal: true

module Likes
  class Destroy < BaseService
    def initialize(user:, like_id:)
      super()
      @user = user
      @like_id = like_id
    end

    def self.call(user:, like_id:)
      new(user:, like_id:).call
    end

    def call
      @like = @user.likes.find(@like_id)
      if @like.destroy
        success_result(@like)
      else
        failure_result(@like)
      end
    end
  end
end
