# spec/factories/medium.rb

FactoryGirl.define do
  factory :medium do
    name {Faker::Book.title}
    plot {Faker::Lorem.sentence}
    media_type {[:movie, :season].sample}
  end
end
