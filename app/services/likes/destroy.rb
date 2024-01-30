# frozen_string_literal: true

module Likes
  class Destroy < BaseService
    def initialize(like:)
      @like = like
    end

    def self.call(like:)
      new(like:).call
    end

    def call
      if @like.destroy
        success_result(@like)
      else
        failure_result(@like)
      end
    end
  end
end
