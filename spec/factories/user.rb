# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :text
#  gender                 :text
#  birthday               :date
#  about                  :text
#  provider               :boolean
#

FactoryGirl.define do
  factory :user do 
    sequence(:email)  { |n| "test#{n}@example.com" }
    password          "password"
    name              { Faker::Name.first_name }
    gender            { ["Male", "Female"].sample }
    birthday          { Faker::Date.between(10.years.ago, 100.years.ago).to_s } 
    about             { Array.new(rand(1..4)) { Faker::StarWars.quote }.join(' ') }
    provider          { [true, false].sample }
    zipcode           { Faker::Address.zip_code }

    food              { [true, false].sample }
    shelter           { [true, false].sample }
    transport         { [true, false].sample }
    shower            { [true, false].sample }
    laundry           { [true, false].sample }
    buddy             { [true, false].sample }
    misc              { [true, false].sample }

    food_info         { Faker::Lorem.paragraph if food      }
    shelter_info      { Faker::Lorem.paragraph if shelter   }
    transport_info    { Faker::Lorem.paragraph if transport }
    shower_info       { Faker::Lorem.paragraph if shower    }
    laundry_info      { Faker::Lorem.paragraph if laundry   }
    buddy_info        { Faker::Lorem.paragraph if buddy     }
    misc_info         { Faker::Lorem.paragraph if misc      }

    shelter_accessible { shelter ? [true, false].sample : false }
    shelter_pets       { shelter ? [true, false].sample : false }

    after(:create)    { |user| user.confirm }

    # Stub out geocoding unless explicitly requested for test speed
    after(:build) do |user| 
      class << user
        def geocode;         true; end
        def set_lonlat;      true; end
        def reverse_geocode; true; end
      end
    end

    trait :with_geocoding do
      after(:build) do |user| 
        class << user
          def geocode;         super; end
          def set_lonlat;      super; end
          def reverse_geocode; super; end
        end
      end
    end
  end
end