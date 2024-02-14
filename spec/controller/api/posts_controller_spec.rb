# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post, user: user) }

  before do
    sign_in(user)
  end

  it 'get all posts' do
    get :index
    expect(response).to be_successful
  end

  it 'find post by id' do
    get :show, params: { id: first_post.id }
    expect(response).to be_successful
  end

  it 'create a new post' do
    post :create, params: { post: { title: 'Post new', body: 'Body' } }
    expect(response).to have_http_status(:success)
    post = JSON.parse(response.body)
    expect(post['title']).to eq('Post new')
    expect(post['body']).to eq('Body')
  end

  it 'destroy post' do
    delete :destroy, params: { id: first_post.id }
    expect(response).to have_http_status(:no_content)
  end
end
