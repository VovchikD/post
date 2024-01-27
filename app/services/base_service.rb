# frozen_string_literal: true

class BaseService
  def success_result(record)
    { status: :success, record: record }
  end

  def failure_result(record)
    { status: :failure, record: record }
  end
end
