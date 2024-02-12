# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostDecorator, type: :decorator do
  let(:post) { build(:post, title: 'title post', body: 'body post') }
  let(:decorated_post) { PostDecorator.decorate(post) }

  it 'capitalizes the title' do
    expect(decorated_post.formatted_title).to eq('Title post')
  end

  it 'capitalizes the body' do
    expect(decorated_post.formatted_body).to eq('Body post')
  end

  it 'formats likes count' do
    expect(decorated_post.formatted_like).to eq('👍 0')
  end

  it 'formats unlikes count' do
    expect(decorated_post.formatted_unlike).to eq('👎 0')
  end
end
