FactoryGirl.define do
  factory :review do 

    # It is recommended to pass these in yourself rather than allow them to be random
    exchange_id     { Exchange.limit(1).order("RANDOM()").first.id }
    author_id       { is_provider_author = [true,false].sample 
                      rand_exchange = Exchange.find(exchange_id)
                      is_provider_author ? rand_exchange.provider_id : rand_exchange.seeker_id   }
    user_id         { is_provider_author = User.find(author_id).provider?
                      rand_exchange = Exchange.find(exchange_id)
                      is_provider_author ? rand_exchange.seeker_id   : rand_exchange.provider_id }

    rating           { rand(1..5)             }
    public_comments  { Faker::Lorem.paragraph }
    private_comments { Faker::Lorem.paragraph }
  end
end