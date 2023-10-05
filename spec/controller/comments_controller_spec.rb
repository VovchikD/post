require 'rails_helper'

RSpec.describe 'Comments_Controller', type: :controller do
  before do
    @controller = CommentsController.new
  end
  
  it 'create comment' do
    post = Post.create(title: 'Title post', body: 'Body post')
    expect do
      patch :create, params: { post_id: post.id, comment: { content: 'A comment' } }
    end.to change(Comment, :count).by(1)
  end
  it 'destroy comment' do
    expect do
      delete :destroy, params: { id: comment.id }
    end
  end
end
