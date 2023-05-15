FactoryBot.define do
  factory :market do
    name { Faker::Hipster.sentence }
    street { Faker::Address.street_name }
    city { Faker::Address.city }
    # no Faker county available, using country instead
    county { Faker::Address.country }
    state { Faker::Address.state }
    zip { Faker::Address.zip }
    lat { Faker::Address.latitude } 
    lon { Faker::Address.longitude }
  end
end
