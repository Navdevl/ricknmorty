# spec/factories/user.rb

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name {Faker::Internet.name}
    password { Faker::Internet.password }
  end
end
