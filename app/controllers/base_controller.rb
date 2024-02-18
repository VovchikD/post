# frozen_string_literal: true

class BaseController < ApplicationController
  include Pundit::Authorization
  include Pagy::Backend
  protect_from_forgery with: :exception

  before_action :authenticate_user!
end
