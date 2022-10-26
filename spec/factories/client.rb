# frozen_string_literal: true

FactoryBot.define do
  factory :client do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    age { rand(30...60) }
    private_note { Faker::Quote.matz }
    address { Faker::Address.full_address }

    trait :with_two_pending_jobs do
      after(:create) do |client|
        2.times do |n|
          new_date = Date.today + (n+1).days
          client.jobs << create(:job, :with_plumber, client: client, date: new_date)
        end
      end
    end
  end
end
