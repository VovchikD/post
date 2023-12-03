# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Comments', type: :system do
  let(:user) { create(:user) }
  let(:first_post) { create(:post, user:) }
  let(:comment) { create(:comment, post: first_post, user:) }

  before do
    driven_by :chrome
    sign_in user
  end

  it 'create comment for post' do
    visit post_path(first_post)
    fill_in 'comment_content', with: 'New comment'
    click_on('Add')

    expect(page).to have_content('New comment')
    expect(Comment.last.content).to eq('New comment')
  end

  it 'destroy comment from post' do
    visit post_path(first_post)
    click_on('Destroy')

    expect(page).not_to have_content(comment)
    expect(Comment.last).to be_nil
  end

  it 'create reply for comment' do
    visit post_path(comment.post)
    fill_in 'comment_content', with: 'A reply', match: :first
    click_on('Reply')

    expect(page).to have_content('A reply')
  end

  it 'destroy reply from comment' do
    create(:comment, post: first_post, parent: comment)
    visit post_path(first_post)
    click_on('Destroy', match: :first)
  end

  it 'validates comment' do
    visit post_path(first_post)
    fill_in 'comment_content', with: ''
    click_on('Add')

    expect(Comment.count).to eq(0)
  end

  it 'validates reply' do
    visit post_path(comment.post)
    fill_in 'comment_content', with: '', match: :first
    click_on('Reply')
    expect(Comment.where.not(parent_id: nil).count).to eq(0)
  end
end
