# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private

    def respond_with(current_user, _opts = {})
      render json: {
        status: {
          code: 200, message: 'Logged in successfully.',
          data: { user: UserSerializer.render(resource) },
          token: Warden::JWTAuth::UserEncoder.new.call(current_user, :users, nil).first
        }
      }, status: :ok
    end

    def respond_to_on_destroy
      if request.headers['Authorization'].present?
        decode_jwt
        current_user = User.find(jwt_payload['sub'])
      end

      current_user ? success_log_out : fail_log_out
    end

    def success_log_out
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    end

    def fail_log_out
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end

    def decode_jwt
      JWT.decode(request.headers['Authorization'].split.last,
                 Rails.application.credentials.devise_jwt_secret_key!).first
    end
  end
end
