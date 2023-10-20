# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:first_post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment, post: first_post) }

  it 'creates a comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id }
    expect(Comment.last).to be_present
  end

  it 'destroy comment' do
    delete :destroy, params: { id: comment.id }
    expect(Comment.last).to be_nil
  end

  it 'creates a reply' do
    post :create, params: { comment: { content: 'A reply', parent_id: comment.id },
                            post_id: first_post.id }
    created_reply = Comment.last
    expect(created_reply.parent_id).to eq(comment.id)
  end

  it 'destroy reply' do
    delete :destroy, params: { id: comment.id, parent_id: comment.id }
    expect(Comment.last).to be_nil
  end
end
