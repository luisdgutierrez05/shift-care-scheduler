# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_length_of(:password).is_at_least(8) }
    it { is_expected.to allow_value('email@test.com').for(:email) }
    it { is_expected.to_not allow_value('foo').for(:email) }

    it 'validates email uniqueness' do
      client = build(:admin_user)
      expect(client).to validate_uniqueness_of(:email).ignoring_case_sensitivity
    end

    it 'requires a matching password confirmation' do
      user = build(:admin_user, password_confirmation: 'invalid')
      expect(user).not_to be_valid
    end
  end
end
