# frozen_string_literal: true

module Likes
  class Create < BaseService
    def initialize(user:, likes_params:)
      super()
      @user = user
      @likes_params = likes_params
    end

    def self.call(user:, likes_params:)
      new(user:, likes_params:).call
    end

    def call
      @like = @user.likes.new(@likes_params)

      if @like.save
        success_result(@like)
      else
        failure_result(@like)
      end
    end
  end
end
