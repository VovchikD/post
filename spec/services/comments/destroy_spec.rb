# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Comments::Destroy, type: :service do
  let(:comment) { create(:comment) }

  it 'when comment successfully destroy' do
    result = Comments::Destroy.call(comment: comment)
    expect(result[:status]).to eq(:success)
    expect(result[:record]).to eq(comment)
  end

  it 'when comment failure destroy' do
    allow(comment).to receive(:destroy)
    result = Comments::Destroy.call(comment: comment)
    expect(result[:status]).to eq(:failure)
    expect(result[:record]).to eq(comment)
  end
end
