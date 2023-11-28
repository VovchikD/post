# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :user, factory: :user

    trait :with_post do
      association :target, factory: :post
    end
    trait :with_comment do
      association :target, factory: :comment
    end
  end
end
