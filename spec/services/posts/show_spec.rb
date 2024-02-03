# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Show, type: :service do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'when user is owner of the post' do
    it 'update comments seen and return success result' do
      allow(post.comments).to receive(:update_all)
      result = Posts::Show.call(post: post, user: user)
      expect(result[:status]).to eq(:success)
      expect(result[:record]).to eq(post)
    end
  end

  context 'when user is not owner of the post' do
    it 'returns success result without update comments' do
      result = Posts::Show.call(post: post, user: create(:user))
      expect(result[:status]).to eq(:success)
      expect(result[:record]).to eq(post)
    end
  end
end
