# frozen_string_literal: true

FactoryBot.define do
  factory :plumber do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    address { Faker::Address.full_address }
    vehicles { { 'MiniVan': 'Toyota' } }
  end
end
