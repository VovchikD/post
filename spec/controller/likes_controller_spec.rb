# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikesController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post) }
  let(:comment) { create(:comment, post: first_post) }
  let(:like_post) { create(:like, :with_post, user:) }
  let(:like_comment) { create(:like, :with_comment, user:) }

  before { sign_in(user) }

  it 'add a new like to post' do
    post :create, params: { like: { target_id: first_post.id, target_type: 'Post' } }
    expect(user.likes.count).to eq(1)
    expect(Like.last.target_id).to eq(first_post.id)
  end

  it 'add a new like to comment' do
    post :create, params: { like: { target_id: comment.id, target_type: 'Comment' } }
    expect(user.likes.count).to eq(1)
    expect(Like.last.target_id).to eq(comment.id)
  end

  it 'delete like from post' do
    delete :destroy, params: { id: like_post.id }
    expect(user.likes.count).to eq(0)
  end

  it 'delete like from comment' do
    delete :destroy, params: { id: like_comment.id }
    expect(user.likes.count).to eq(0)
  end
end
