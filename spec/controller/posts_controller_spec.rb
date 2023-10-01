require 'rails_helper'

RSpec.describe 'Posts', type: :controller do
  let(:post) { { title: 'Post 1', body: 'Content 1' } }
  it 'index' do
    post1 = Post.all
    expect(post1)
  end

  it 'show' do
    expect(post)
  end

  it 'new' do
    post = Post.new
    expect(post)
  end

  it 'create a new post' do
    post = Post.new(post)
    expect(post.save)
  end

  it 'destroy post' do
    expect { post.destroy }
  end
end
