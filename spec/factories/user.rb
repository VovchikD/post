FactoryBot.define do
  factory :user do
    email { 'user@example.com' }
    password { 'password123' }
  end

  factory :another_user, class: User do
    email { 'another_user@example.com' }
    password { 'another_password123' }
  end
end