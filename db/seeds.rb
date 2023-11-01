# frozen_string_literal: true

10.times do
  Post.create(title: Faker::Hipster.sentences.sample, body: Faker::Hipster.sentences.sample)
end
