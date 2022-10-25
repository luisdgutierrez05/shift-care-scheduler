# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user, class: 'AdminUser' do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { 'Password123!' }
    password_confirmation { 'Password123!' }
  end
end
