# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentDecorator, type: :decorator do
  let(:post) { create(:post) }
  let(:comment) { create(:comment, post: post) }
  let(:decorated_comment) { CommentDecorator.decorate(comment) }

  it 'capitalizes the content' do
    expect(decorated_comment.formatted_content).to eq('A comment')
  end

  it 'formats likes count' do
    expect(decorated_comment.formatted_like).to eq('👍 0')
  end

  it 'formats unlikes count' do
    expect(decorated_comment.formatted_unlike).to eq('👎 0')
  end
end
