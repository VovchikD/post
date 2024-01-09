# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UnseenCommentsNotificationJob, type: :job do
  let(:user) { create(:user) }
  include ActiveJob::TestHelper

  it 'queues the job' do
    expect do
      UnseenCommentsNotificationJob.perform_later
    end.to have_enqueued_job(UnseenCommentsNotificationJob)
  end

  it 'sends notification email' do
    create(:comment, user: user, seen: false)
    expect do
      perform_enqueued_jobs do
        UnseenCommentsNotificationJob.perform_later
      end
    end.to change { ActionMailer::Base.deliveries.size }.by(1)
  end
end
