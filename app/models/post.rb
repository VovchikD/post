# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, as: :target
  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :body,  presence: true, length: { minimum: 3, maximum: 200 }
end
