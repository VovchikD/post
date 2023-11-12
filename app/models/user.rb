# frozen_string_literal: true

class User < ApplicationRecord
  has_many :posts,    dependent: :destroy, foreign_key: :user_id
  has_many :comments, dependent: :destroy, foreign_key: :user_id
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
end
