# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post, user: user) }
  let(:comment) { create(:comment, post: first_post, user: user) }
  let(:like_params_post) { { target_id: first_post.id, target_type: 'Post' } }
  let(:like_params_comment) { { target_id: comment.id, target_type: 'Comment' } }
  let(:like_post) { create(:like, target: first_post, user: user) }
  let(:like_comment) { create(:like, target: comment, user: user) }

  before do
    sign_in(user)
  end

  it 'create like for post' do
    post :create, params: { like: like_params_post }
    expect(response).to have_http_status(:success)
  end

  it 'destroy like for post' do
    delete :destroy, params: { id: like_post.id }
    expect(response).to have_http_status(:no_content)
  end

  it 'create like for comment' do
    post :create, params: { like: like_params_comment }
    expect(response).to have_http_status(:success)
  end

  it 'destroy like for comment' do
    delete :destroy, params: { id: like_comment.id }
    expect(response).to have_http_status(:no_content)
  end
end
