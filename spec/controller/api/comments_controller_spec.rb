# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post, user: user) }
  let(:comment) { create(:comment, post: first_post, user: user) }

  before do
    sign_in(user)
  end

  it 'create comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id }
    expect(response).to have_http_status(:success)
    comment = JSON.parse(response.body)
    expect(comment['content']).to eq('A comment')
  end

  it 'destroy comment' do
    delete :destroy, params: { id: comment.id }
    expect(response).to have_http_status(:no_content)
  end
end
