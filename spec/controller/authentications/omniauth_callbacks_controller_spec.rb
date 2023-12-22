# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Authentications::OmniauthCallbacksController, type: :controller do
  let(:user) { create(:user) }
  let(:auth_data) { OmniAuth.config.mock_auth[:facebook] }
  let(:auth_data) { OmniAuth.config.mock_auth[:google_oauth2] }

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    request.env['omniauth.auth'] = auth_data
  end

  describe '#google_oauth2' do
    context 'when user is persisted' do
      it 'redirects to success path' do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(true)
        get :google_oauth2
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not persisted' do
      it 'redirects to new_user_registration_path' do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(false)
        allow(request.env['omniauth.auth']).to receive(:except).with('extra').and_return({})
        get :google_oauth2
        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end
  describe '#facebook' do
    context 'when user is persisted' do
      it 'redirects to success path' do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(true)
        get :facebook_oauth2
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when user is not persisted' do
      it 'redirects to new_user_registration_path' do
        allow(User).to receive(:from_omniauth).and_return(user)
        allow(user).to receive(:persisted?).and_return(false)
        allow(request.env['omniauth.auth']).to receive(:except).with('extra').and_return({})
        get :facebook_oauth2
        expect(response).to redirect_to(new_user_registration_path)
      end
    end
  end
end
