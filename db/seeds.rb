# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do
  FactoryGirl.create :user(User.default_privacy), :with_geocoding
end

User.all.each do |user|
  create_params = user.provider? ? {provider_id: user.id} : {seeker_id: user.id}
  rand(0..4).times do
    FactoryGirl.create :exchange, create_params
  end
end

Exchange.where(s_finished: true, p_finished: true).each do |exchange|
  provider_review = { author_id: exchange.provider_id, user_id: exchange.seeker_id,   exchange_id: exchange.id }
  seeker_review   = { author_id: exchange.seeker_id,   user_id: exchange.provider_id, exchange_id: exchange.id }

  FactoryGirl.create(:review, provider_review) if [true,false].sample
  FactoryGirl.create(:review, seeker_review)   if [true,false].sample
end