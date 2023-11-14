# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    content { 'A comment' }
    association :post, factory: :post
    association :user, factory: :user
  end
end
