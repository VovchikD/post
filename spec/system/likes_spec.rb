# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }
  let(:comment) { create(:comment, post:, user: user) }

  before do
    driven_by :chrome
    sign_in user
  end

  it 'add new like to post' do
    visit post_path(post)
    click_on('👍 0')

    expect(page).to have_content('👎 1')
  end

  it 'destroy like from post' do
    create(:like, user:, target: post)
    visit post_path(post)
    click_on('👎 1')

    expect(page).to have_button('👍 0')
  end

  it 'add new like to comment' do
    visit post_path(comment.post)
    within('.actions.comment_like') do
      click_button('👍 0')
    end
    expect(page).to have_content('👎 1')
  end

  it 'destroy like from comment' do
    create(:like, user:, target: comment)
    visit post_path(post)
    within('.old_like') do
      click_button('👎 1')
    end
    expect(page).to have_button('👍 0')
  end
end
