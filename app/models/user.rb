# frozen_string_literal: true

class User < ApplicationRecord
  has_many :post
  has_many :comments
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
