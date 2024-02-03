# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comments::Create, type: :service do
  let(:user) { create(:user) }
  let(:post) { create(:post) }

  context 'when comment create success' do
    let(:comment_params) { { content: 'New comment' } }

    it 'return success result' do
      result = Comments::Create.call(user: user, post: post, comment_params: comment_params)
      expect(result[:status]).to eq(:success)
      expect(result[:record].content).to eq('New comment')
    end
  end

  context 'when comment create fails' do
    let(:comment_params) { { content: '' } }

    it 'return fails result' do
      result = Comments::Create.call(user: user, post: post, comment_params: comment_params)
      expect(result[:status]).to eq(:failure)
    end
  end
end
