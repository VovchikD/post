# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Likes', type: :system do
  let(:user) { create(:user) }
  let(:post) { create(:post, user:) }
  let(:comment) { create(:comment, post:, user:) }

  before do
    sign_in user
  end

  it 'add new like to post' do
    visit post_path(post)
    click_on("Like #{post.likes.count}")

    expect(page).to have_content("Unlike #{post.likes.count + 1}")
  end

  it 'destroy like from post' do
    create(:like, user:, target: post)
    visit post_path(post)
    click_on("Unlike #{post.likes.count}")

    expect(page).not_to have_content("Unlike #{post.likes.count}")
  end
end
