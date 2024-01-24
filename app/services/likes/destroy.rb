# frozen_string_literal: true

module Likes
  class Destroy
    def initialize(user:, like_id:)
      @user = user
      @like_id = like_id
    end

    def self.call(user:, like_id:)
      new(user:, like_id:).call
    end

    def call
      @like = @user.likes.find(@like_id)
      if @like.destroy
        success_result
      else
        failure_result
      end
    end

    private

    def success_result
      { status: :success, record: @like }
    end

    def failure_result
      { status: :failure, record: @like }
    end
  end
end
