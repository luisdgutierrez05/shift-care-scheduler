# frozen_string_literal: true

FactoryBot.define do
  factory :job_plumber do
    association(:job)
    association(:plumber)
  end
end
