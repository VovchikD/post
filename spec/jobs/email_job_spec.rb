# frozen_string_literal: true
# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe EmailJob, type: :job do
#   include ActiveJob::TestHelper

#   it 'sends email when user unseen comments' do
#     EmailJob.perform_later
#     expect(ActiveJob::Base.queue_adapter.enqueued_jobs.size).to eq(1)
#   end
# end
