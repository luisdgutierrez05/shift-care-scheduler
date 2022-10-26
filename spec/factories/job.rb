# frozen_string_literal: true

FactoryBot.define do
  factory :job do
    status { :pending }
    description { Faker::Marketing.buzzwords }
    date { Date.today + 1.days }
    association(:client)

    trait :with_plumber do
      after(:create) do |job|
        job.plumbers << create(:plumber)
      end
    end

    trait :with_specific_plumber do
      transient do
        plumber { nil }
      end

      after(:create) do |job, options|
        job.plumbers << options.plumber
      end
    end

    trait :with_status_done do
      status { :done }
    end
  end
end
