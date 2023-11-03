# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:first_post) { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment, post: first_post) }
  let(:post_author) { create(:user) }
  let(:second_post) { create(:post, user_id: post_author) }
  

  it 'creates a comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id }
    expect(Comment.last).to be_present
  end

  it 'send an email to the post author' do
    sign_in post_author
      post :create, params: { post_id: second_post.id, comment: { content: 'A comment' } }
      expect(ActionMailer::Base.deliveries.size).to be_present
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
