require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:first_post)    { FactoryBot.create(:post) }
  it 'renders to index' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'create a new post' do
    post :create, params: { post: { title: 'Post new', body: 'Content 2' } }
    expect(Post.last).to be_present
  end

  it 'destroy post' do
    delete :destroy, params: { id: first_post.id }
    expect(Post.last).to be_nil
  end
end