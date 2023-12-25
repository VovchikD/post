# frozen_string_literal: true

module Authentications
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        success_google_auth
      else
        failed_google_auth
      end
    end

    def facebook_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        success_facebook_auth
      else
        failed_facebook_auth
      end
    end

    private

    def success_facebook_auth
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Success'
    end

    def failed_facebook_auth
      session['devise.facebook_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_path, alert: @user.errors.full_messages
    end

    def success_google_auth
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Success'
    end

    def failed_google_auth
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_path, alert: @user.errors.full_messages
    end
  end
end
