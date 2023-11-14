# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post) }

  before do
    sign_in(user)
  end

  it 'renders to index' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'find post by id' do
    get :show, params: { id: first_post.id }
    expect(assigns(:post)).to eq(first_post)
  end

  it 'be a new post' do
    get :new
    expect(assigns(:post)).to be_a_new(Post)
  end

  it 'create a new post' do
    post :create, params: { post: { title: 'Post new', body: 'Content 2' } }
    expect(Post.last).to be_present
  end

  it 'renders new' do
    post :create, params: { post: { title: '', body: '' } }
    expect(response).to render_template(:new)
  end
  
  context 'create new post' do 
    let(:second_post) { create(:post) }

    it 'destroy post' do
      expect {
        delete :destroy, params: { id: second_post.id }
      }.to change(Post, :count).by(0)
    end
  end
end
