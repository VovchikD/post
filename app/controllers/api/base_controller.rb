# frozen_string_literal: true

module Api
  class BaseController < ApplicationController
    include Pundit::Authorization
    include Pagy::Backend
    skip_before_action :verify_authenticity_token

    before_action :authenticate_user!
  end
end
