# frozen_string_literal: true

class User < ApplicationRecord
  has_many :post,    dependent: :destroy
  has_many :comment, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
