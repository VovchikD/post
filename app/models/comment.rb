# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  has_many :replies, dependent: :destroy
end
