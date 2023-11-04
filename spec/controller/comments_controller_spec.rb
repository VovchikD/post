# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:first_post) { FactoryBot.create(:post, user: user) }
  let(:comment) { FactoryBot.create(:comment, post: first_post, user: user) }

  it 'creates a comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: first_post.id, user_id: user.id }
    expect(Comment.last).to be_present
  end

  it 'send an email to the post author' do
    mail = CommentMailer.new_comment(user, comment)
    expect(mail.subject).to eq('New massege under your post')
    expect {
      mail.deliver_now
    }.to change(ActionMailer::Base.deliveries, :count).by(1)
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
