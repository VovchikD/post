# frozen_string_literal: true

module Likes
  class Create
    def initialize(user:, likes_params:)
      @user = user
      @likes_params = likes_params
    end

    def self.call(user:, likes_params:)
      new(user:, likes_params:).call
    end

    def call
      @like = @user.likes.new(@likes_params)

      if @like.save
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
