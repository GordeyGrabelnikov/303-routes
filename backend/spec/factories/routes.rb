# frozen_string_literal: true

FactoryBot.define do
  factory :route do
    name { Faker::Name.first_name }
    user_id { create(:user).id }
  end
end
