# frozen_string_literal: true

module Likes
  class Create < BaseService
    def initialize(user:, like_params:)
      @user = user
      @like_params = like_params
    end

    def self.call(user:, like_params:)
      new(user:, like_params:).call
    end

    def call
      @like = @user.likes.new(@like_params)

      if @like.save
        success_result(@like)
      else
        failure_result(@like)
      end
    end
  end
end
