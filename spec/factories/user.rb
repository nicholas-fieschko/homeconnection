FactoryGirl.define do
  factory :user do 
    sequence(:email)  { |n| "test#{n}@example.com" }
    password          "12345678"
    confirmed_at      { Time.now }
    name              { Faker::Name.first_name }
    gender            { ["Male", "Female"].sample }
    birthday          { Faker::Date.between(10.years.ago, 100.years.ago).to_s } 
    about             { Faker::Lorem.paragraph }
    provider          { [true, false].sample }
  end
end