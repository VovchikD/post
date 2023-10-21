# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3, maximum: 15 }
  validates :body,  presence: true, length: { minimum: 3, maximum: 15 }
end
