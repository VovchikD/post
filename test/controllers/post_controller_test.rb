# frozen_string_literal: true

class PostControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get post_index_url
    assert_response :success
  end
end
