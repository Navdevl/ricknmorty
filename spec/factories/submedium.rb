# spec/factories/submedium.rb

FactoryGirl.define do
  factory :submedium do
    name {Faker::Book.title}
    plot {Faker::Lorem.sentence}
    sub_id {0}
  end
end
