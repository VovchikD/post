require 'rails_helper'

RSpec.describe 'Comments_Controller', type: :controller do
  let(:comment) { { content: 'a comment' } }
  it 'create comment' do
    comment = Comment.new
    expect { comment.save }
  end
  it 'destroy comment' do
    comment1 = { content: 'old comment' }
    expect { comment1.destroy }
  end
end
