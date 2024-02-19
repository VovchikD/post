# frozen_string_literal: true

class CommentSerializer < Blueprinter::Base
  identifier :id

  fields :content, :user_id, :parent_id, :created_at
end
