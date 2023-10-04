require 'rails_helper'

RSpec.describe 'Comments_Controller', type: :controller do
  it 'create comment' do
    expect do
      post :create, params: { comment: 'New Comment', post_id: post.id }
    end
  end
  it 'destroy comment' do
    expect do
      delete :destroy, params: { id: comment.id }
    end
  end
end
