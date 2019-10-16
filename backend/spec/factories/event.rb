# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    name { Faker::FunnyName.name }
    description { Faker::Lorem.sentence }
    date { Faker::Date.forward }
    route_id { create(:route).id }
  end
end