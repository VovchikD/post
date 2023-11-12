# frozen_string_literal: true

User.create(
  email: 'user@example.com',
  password: '1234567890'
)

10.times do
  Post.create(title: Faker::Hipster.sentences.sample, body: Faker::Hipster.sentences.sample)
end
