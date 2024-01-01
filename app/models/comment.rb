# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :parent,   class_name: 'Comment',   optional: true
  has_many   :comments, class_name: 'Comment',   foreign_key: :parent_id, dependent: :destroy
  has_many :likes, as: :target, dependent: :destroy
  validates :content, presence: true
  scope :unseen, -> { where(seen: false) }

  def self.unseen_comments
    unseen.order(created_at: :desc)
  end

  def seen_comments
    update(seen: true)
  end
end
