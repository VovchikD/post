# frozen_string_literal: true

class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :body,  presence: true, length: { minimum: 3, maximum: 200 }
end
