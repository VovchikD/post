# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        success_google_oauth2
      else
        failed_google_oauth2
      end
    end

    def facebook_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        success_facebook_oauth2
      else
        failed_facebook_oauth2
      end
    end

    private

    def success_facebook_oauth2
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Success'
    end

    def failed_facebook_oauth2
      session['devise.facebook_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_path, alert: @user.errors.full_messages
    end

    def success_google_oauth2
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Success'
    end

    def failed_google_oauth2
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_path, alert: @user.errors.full_messages
    end
  end
end
