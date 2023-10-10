FactoryBot.define do
  factory :comment do
    content { 'A comment' }
    association :post, factory: :post
  end
end
