# frozen_string_literal: true

module Comments
  class Destroy
    def initialize(comment:)
      @comment = comment
    end

    def self.call(comment:)
      new(comment:).call
    end

    def call
      if @comment.destroy
        success_result
      else
        failure_result
      end
    end

    private

    def success_result
      { status: :success, record: @comment }
    end

    def failure_result
      { status: :failure, record: @comment }
    end
  end
end
