10.times do
  Post.create(title: Faker::Hipster.sentences.sample, body: Faker::Hipster.sentences.sample)
end
