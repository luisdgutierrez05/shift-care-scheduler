# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Plumber, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:job_plumbers).class_name('JobPlumber') }
    it { is_expected.to have_many(:jobs).through(:job_plumbers) }
    it { is_expected.to have_many(:clients).through(:jobs) }
    it { is_expected.to accept_nested_attributes_for(:job_plumbers) }
  end

  describe 'Validations' do
    subject { build(:plumber) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:address) }
  end
end
