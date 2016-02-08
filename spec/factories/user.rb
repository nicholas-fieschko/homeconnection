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
    password          "12345678"
    name              { Faker::Name.first_name }
    gender            { ["Male", "Female"].sample }
    birthday          { Faker::Date.between(10.years.ago, 100.years.ago).to_s } 
    about             { Faker::Lorem.paragraph }
    provider          { [true, false].sample }

    after(:create)    { |user| user.confirm }
  end
end