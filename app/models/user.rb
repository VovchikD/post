# frozen_string_literal: true

class User < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :liked_comments, through: :likes, source: :target, source_type: 'Comment'
  has_many :liked_posts, through: :likes, source: :target, source_type: 'Post'
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 facebook]
end
