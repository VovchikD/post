# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        success_authentication
      else
        failed_authentication
      end
    end

    private

    def success_authentication
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = 'Success'
    end

    def failed_authentication
      session['devise.google_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_user_registration_path, alert: @user.errors.full_messages
    end
  end
end
