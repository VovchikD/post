# frozen_string_literal: true

class CommentDecorator < ApplicationDecorator
  delegate_all

  def formatted_content
    content.capitalize
  end

  def formatted_like
    "👍 #{likes.count}"
  end

  def formatted_unlike
    "👎 #{likes.count}"
  end
end
