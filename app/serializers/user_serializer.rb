# frozen_string_literal: true

class UserSerializer < Blueprinter::Base
  identifier :id

  fields :email
end
