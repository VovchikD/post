# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post, user:) }
  let(:comment) { create(:comment, post: first_post, user:) }

  before { sign_in(user) }

  it 'creates a comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id }
    expect(Comment.last).to be_present
  end

  context 'when enter by another user' do
    let(:commentator) { create(:user) }

    it 'sends an email from another user' do
      sign_in(commentator)
      expect do
        post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id }
      end.to change(ActionMailer::Base.deliveries, :count).by(1)
    end
  end

  it 'destroy comment' do
    delete :destroy, params: { id: comment.id }
    expect(Comment.last).to be_nil
  end

  it 'creates a reply' do
    post :create, params: { comment: { content: 'A reply', parent_id: comment.id },
                            post_id: first_post.id }
    expect(Comment.last.parent_id).to eq(comment.id)
  end

  it 'renders posts/show' do
    post :create, params: { comment: { content: '' }, post_id: first_post.id }
    expect(response).to render_template('posts/show')
  end

  it 'destroy reply' do
    delete :destroy, params: { id: comment.id, parent_id: comment.id }
    expect(Comment.last).to be_nil
  end
end
