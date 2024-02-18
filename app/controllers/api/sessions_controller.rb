# frozen_string_literal: true

module Api
  class SessionsController < Devise::SessionsController
    respond_to :json
    skip_before_action :verify_authenticity_token

    private

    def respond_with(resource, _opts = {})
      render json: {
        status: { code: 200, message: 'Logged in successfully.' },
        data: UserSerializer.render(resource),
        token: generate_jwt_token(resource)
      }, status: :ok
    end

    def respond_to_on_destroy
      jwt_payload = decode_jwt_payload
      if jwt_payload.present?
        find_user_by_jwt_payload(jwt_payload)
        success_sign_out
      else
        fail_sing_out
      end
    end

    def decode_jwt_payload
      auth_header = request.headers.fetch('Authorization', '').split.last
      return nil if auth_header.blank?

      JWT.decode(auth_header, Rails.application.credentials.devise_jwt_secret_key, true, algorithm: 'HS256').first
    rescue JWT::DecodeError => e
      Rails.logger.error("JWT decode error: #{e.message}")
      nil
    end

    def find_user_by_jwt_payload(jwt_payload)
      User.find_by(id: jwt_payload['sub'])
    end

    def generate_jwt_token(resource)
      JWT.encode({ user_id: resource.id }, Rails.application.credentials.devise_jwt_secret_key, 'HS256')
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
