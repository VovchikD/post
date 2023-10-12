# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :parent,  class_name: 'Comment', optional: true
  has_many   :comments, foreign_key: :parent_id, dependent: :destroy
end
