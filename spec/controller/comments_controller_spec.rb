require 'rails_helper'


RSpec.describe 'CommentsController', type: :controller do 
  let(:post)    { FactoryBot.create(:post) }
  let(:comment) { FactoryBot.create(:comment) }

  it 'creates a comment' do
    expect do
      post :create, params: { comment: { content: 'A comment' }, post_id: post.id }
      created_comment = Comment.find(content: 'A comment')
      created_comment.to be_present
  end
end
  it 'destroy comment' do
    expect do
      delete :destroy, params: { id: comment.id }
      destroy_comment = Comment.find_by(id: comment.id)
      destroyed_comment.to be_nil
      end
    end
end