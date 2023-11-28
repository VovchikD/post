# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true
  validates :user_id, uniqueness: { scope: %i[target_id target_type] }
end
