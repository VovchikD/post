# require 'rails_helper'
# require 'koala'

# RSpec.describe 'Facebook OAuth authentication', type: :system do

#   before do
#     #driven_by :chrome
#     @test_users = Koala::Facebook::TestUsers.new(:app_id => 880772610436104, :secret => "6a7f1b5f268dd8f439ebf96ac1f952a9")
#     @test_user = @test_users.create(false)
#     # @test_users_list = @test_users.list
#     # @test_user = @test_users_list.first
#   end

#   it 'allows users to sign in with Facebook' do
#     visit new_user_registration_path
#     click_on('Sign up with Facebook')
#     #expect(page).to have_current_path(root_path)
#   end

#   it 'allows users to sign in with OAuth' do
#     visit new_user_registration_path
#     click_on('Sign up with OAuth')
#     expect(page).to have_current_path(root_path)
#   end
# end