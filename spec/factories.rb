FactoryBot.define do
  factory :category do
    name Faker::Name
  end

  factory :user do
    fname Faker::Name.first_name
    lname Faker::Name.last_name
    mobile 123_456_789
    email Faker::Internet.email
    birthdate 20.years.ago
    password "foobar"
  end

  factory :product do
    name Faker::Name
    description Faker::Lorem
    price Faker::Number.decimal(2)
  end
end
