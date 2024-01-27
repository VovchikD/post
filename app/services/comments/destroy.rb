# frozen_string_literal: true

module Comments
  class Destroy < BaseService
    def initialize(comment:)
      @comment = comment
    end

    def self.call(comment:)
      new(comment:).call
    end

    def call
      if @comment.destroy
        success_result(@comment)
      else
        failure_result(@comment)
      end
    end
  end
end
