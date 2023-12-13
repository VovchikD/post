# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :system do
  let(:user) { create(:user) }

  before do
    driven_by :chrome
    sign_in user
  end

  it 'creates a new post' do
    visit new_post_path
    fill_in 'post_title', with: 'Test Post'
    fill_in 'post_body', with: 'Test Body'
    click_on('Create Post')

    expect(page).to have_content('Test Post')
    expect(page).to have_content('Test Body')
  end

  it 'destroy a post' do
    post = create(:post, user:)

    visit post_path(post)
    click_on('Destroy this post')

    expect(page).not_to have_content(post.title)
    expect(page).not_to have_content(post.body)
  end

  it 'validates post' do
    visit new_post_path
    fill_in 'post_title', with: 'x' * 201
    fill_in 'post_body', with: 'x' * 201
    click_on('Create Post')

    expect(Post.count).to eq(0)
  end

  it 'pagination posts' do
    posts = create_list(:post, 11)
    visit root_path
    click_on('Next')
    expect(page).to have_content(posts.last.title)

    click_on('Prev')
    expect(page).to have_content(posts.first.title)
  end
end
