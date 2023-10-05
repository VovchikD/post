require 'rails_helper'


RSpec.describe 'CommentsController', type: :controller do 
  it 'creates a comment' do
    expect do
      post :create, params: { post_id: post.id, comment: { content: 'A comment' } }
    end.to change(Comment, :count).by(1)
  end
  it 'destroy comment' do
    expect do
      delete :destroy, params: { id: comment.id }
      end
    end
end