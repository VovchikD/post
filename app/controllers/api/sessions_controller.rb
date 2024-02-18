# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private

    def respond_with(resource, _opts = {})
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.render(resource)
      }, status: :ok
    end

    def respond_to_on_destroy
      jwt_payload = decode_jwt_payload
      if jwt_payload.present?
        current_user = find_user_by_jwt_payload(jwt_payload)
        current_user ? success_sign_out : fail_sign_out
      else
        fail_sign_out
      end
    end

    def decode_jwt_payload
      JWT.decode(request.headers['Authorization'].split.last,
                 Rails.application.credentials.devise_jwt_secret_key).first
    rescue JWT::DecodeError
      nil
    end

    def find_user_by_jwt_payload(jwt_payload)
      User.find_by(id: jwt_payload['sub'])
    end

    def success_sign_out
      sign_out(current_user)
      render json: {
        status: 200,
        message: 'Logged out successfully.'
      }, status: :ok
    end

    def fail_sing_out
      render json: {
        status: 401,
        message: "Couldn't find an active session."
      }, status: :unauthorized
    end
  end
end
