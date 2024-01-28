# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Likes::Create, type: :service do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  it 'returns success result' do
    likes_params = { target_id: post.id, target_type: 'Post' }
    result = Likes::Create.call(user: user, likes_params: likes_params)
    expect(result[:status]).to eq(:success)
    expect(result[:record]).to be_a(Like)
  end

  it 'returns failure result' do
    likes_params = { target_id: post.id }
    result = Likes::Create.call(user: user, likes_params: likes_params)
    expect(result[:status]).to eq(:failure)
  end
end
