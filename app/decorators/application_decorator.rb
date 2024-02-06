# frozen_string_literal: true

class ApplicationDecorator < Draper::Decorator
  def formatted_like
    "👍 #{likes.count}"
  end

  def formatted_unlike
    "👎 #{likes.count}"
  end
end
