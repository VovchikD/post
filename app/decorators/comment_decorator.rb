# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  delegate_all

  def formatted_content
    content.capitalize
  end
end
