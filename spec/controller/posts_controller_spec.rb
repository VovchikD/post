# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:first_post) { create(:post) }
  let(:comment) { create(:comment, post: first_post, user:) }

  before do
    sign_in(user)
  end

  it 'renders to index' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'pagination posts' do
    create_list(:post, 10)
    get :index
    pagy = assigns(:pagy)
    expect(pagy.count).to eq(10)
  end

  it 'pagination comments' do
    create_list(:comment, 10, post: first_post)
    get :show, params: { id: first_post.id }
    comment_pagy = assigns(:comment_pagy)
    expect(comment_pagy.count).to eq(10)
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

  it 'destroy post' do
    delete :destroy, params: { id: first_post.id }
    expect(Post.last).to be_nil
  end
end
