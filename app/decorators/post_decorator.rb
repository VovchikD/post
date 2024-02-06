# frozen_string_literal: true

class PostDecorator < ApplicationDecorator
  delegate_all

  def formatted_title
    title.capitalize
  end

  def formatted_body
    body.capitalize
  end
end
