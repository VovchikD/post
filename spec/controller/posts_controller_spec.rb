require 'rails_helper'

RSpec.describe 'Posts', type: :controller do
  before do
    @controller = PostsController.new
  end

  it 'renders to index' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'action show' do
    get :show, params: { id: post.id }
    expect(response)
  end

  it 'create a new post' do
    post_params = { title: 'Post new', body: 'Content 2' }
    post = Post.new(post_params)
    expect { post.save }.to change(Post, :count).by(1)
  end

  it 'destroy post' do
    post1 = { title: 'Post 1', body: 'Content 1' }
    expect { post1.destroy }
  end
end
