# frozen_string_literal: true

user = User.create(email: Faker::Internet.email, password: '123456')

10.times do
  user.posts.create(title: Faker::Hipster.sentence, body: Faker::Hipster.sentence)
end
