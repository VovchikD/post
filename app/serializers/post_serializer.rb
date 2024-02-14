# frozen_string_literal: true

class PostSerializer < Blueprinter::Base
  identifier :id

  fields :title, :body, :created_at
end
