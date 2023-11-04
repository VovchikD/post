# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Title post' }
    body { 'Body post' }
    association :user, factory: :user
  end
end
