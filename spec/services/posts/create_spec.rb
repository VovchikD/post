# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Posts::Create, type: :service do
  let(:user) { create(:user) }

  describe 'call' do
    context 'when post creation is successful' do
      let(:post_params) { { title: 'Title post', body: 'Body post' } }

      it 'returns success result' do
        result = Posts::Create.call(user: user, post_params: post_params)
        expect(result[:status]).to eq(:success)
        expect(result[:record].title).to eq('Title post')
      end
    end

    context 'when post creation fails' do
      let(:post_params) { { title: '', body: '' } }

      it 'returns failure result' do
        result = Posts::Create.call(user: user, post_params: post_params)
        expect(result[:status]).to eq(:failure)
      end
    end
  end
end
