require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:posts)    { FactoryBot.create(:post) }
  let(:comment)  { FactoryBot.create(:comment, post: posts) }

  it 'creates a comment' do
    post :create, params: { comment: { content: 'A comment' }, post_id: posts.id }
    expect(Comment.last).to be_present
  end

  it 'destroy comment' do
    delete :destroy, params: { id: comment.id }
    expect(Comment.last).to be_nil
  end
end
