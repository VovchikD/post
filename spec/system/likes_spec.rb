# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:comment) { create(:comment, post:, user:) }
  let(:like_post) { create(:like, :with_post, user:) }

  before do
    sign_in user
  end

  it 'add new like to post' do
    visit post_path(post)
    click_on('Like 0')

    expect(page).to have_content('Unlike 1')
  end

  it 'destroy like from post' do
    create(:like, user:, target: post)
    visit post_path(post)
    click_on('Unlike 1')

    expect(page).not_to have_content('Like 0')
  end
end
