FactoryGirl.define do
  factory :todo do
    name Faker::StarWars.planet
    body Faker::StarWars.quote
    created_at Time.now.to_s
  end
end