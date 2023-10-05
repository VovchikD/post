require 'rails_helper'


RSpec.describe 'CommentsController', type: :controller do 
  let(:post) { FactoryBot.create(:post) }

  it 'creates a comment' do
    expect do
      post :create, params: {  comment: { content: 'A comment' }, post_id: post.id   }
    end.to change(Comment, :count).by(1)
  end
  it 'destroy comment' do
    expect do
      delete :destroy, params: { id: comment.id }
      end
    end
end