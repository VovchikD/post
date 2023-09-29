require 'rails_helper'

RSpec.describe "Comments_Controller", type: :controller do
    it 'create a new comment' do
        comment_value = { content: 'Valid comment' }
        comment = Comment.new(comment_value)
        expect{comment.save}
    end

    it 'destroy comment' do 
        comment = { content: 'Valid comment' }
    expect {comment.destroy}
    end
end
