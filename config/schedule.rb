# frozen_string_literal: true

every 1.hour do
  runner 'UnseenCommentsNotificationJob.perform_later'
end
