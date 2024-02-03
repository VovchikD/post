# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Destroy, type: :service do
  let(:post) { create(:post) }

  it 'when post is successfully destroy' do
    result = Posts::Destroy.call(post: post)
    expect(result[:status]).to eq(:success)
    expect(result[:record]).to eq(post)
  end

  it 'when post is failure destroy' do
    allow(post).to receive(:destroy)
    result = Posts::Destroy.call(post: post)
    expect(result[:status]).to eq(:failure)
    expect(result[:record]).to eq(post)
  end
end
