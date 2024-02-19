# frozen_string_literal: true

module Api
  class RegistrationsController < Devise::RegistrationsController
    include RackSessionsFix
    respond_to :json
    skip_before_action :verify_authenticity_token

    private

    def respond_with(resource, _opts = {})
      if resource.persisted?
        render json: {
          status: { code: 200, message: 'Signed up successfully.' },
          data: UserSerializer.render(resource)
        }
      else
        render json: {
          status: { code: 422, message: resource.errors.full_messages }
        }, status: :unprocessable_entity
      end
    end
  end
end
