# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Likes::Destroy, type: :service do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:like) { create(:like, user: user, target: post) }

  it 'when like destroy success' do
    result = Likes::Destroy.call(like: like)
    expect(result[:status]).to eq(:success)
    expect(result[:record]).to eq(like)
  end

  it 'when like destroy failure' do
    allow_any_instance_of(Like).to receive(:destroy)
    result = Likes::Destroy.call(like: like)
    expect(result[:status]).to eq(:failure)
    expect(result[:record]).to eq(like)
  end
end
