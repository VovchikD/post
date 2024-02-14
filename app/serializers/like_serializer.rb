# frozen_string_literal: true

class LikeSerializer < Blueprinter::Base
  identifier :id

  fields :user_id, :target_id, :target_type, :created_at
end
