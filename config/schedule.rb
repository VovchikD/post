# frozen_string_literal: true

every 1.hour do
  runner 'SendEmailJob.perform_later'
end
