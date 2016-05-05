FactoryGirl.define do
  factory :exchange do 
    # It is recommended to pass these in yourself rather than allow them to be random
    provider_id     { User.where(provider: true ).limit(1).order("RANDOM()").first.id    }
    seeker_id       { User.where(provider: false).limit(1).order("RANDOM()").first.id    }

    s_accepted      { [true, false].sample                     }
    p_accepted      { s_accepted ? [true, false].sample : true }

    s_finished      { s_accepted && p_accepted ? [true, false].sample : false }
    p_finished      { s_accepted && p_accepted ? [true, false].sample : false }
  end
end