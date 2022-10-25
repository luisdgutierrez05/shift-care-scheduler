# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:jobs) }
    it { is_expected.to have_many(:plumbers).through(:jobs) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:age) }
    it { is_expected.to validate_presence_of(:private_note) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to allow_value('email@test.com').for(:email) }
    it { is_expected.to_not allow_value('foo').for(:email) }

    it 'validates email uniqueness' do
      client = build(:client)
      expect(client).to validate_uniqueness_of(:email).ignoring_case_sensitivity
    end
  end

  describe 'Instance Methods' do
    describe '#pending_jobs' do
      let(:client) { create(:client) }

      context 'when Client have pending jobs' do
        let(:job_one) { create(:job, :with_plumber, client: client) }
        let(:job_two) { create(:job, :with_plumber, client: client, date: Time.zone.today.end_of_month) }
        let(:job_three) { create(:job, :with_plumber, client: client, date: Time.zone.today + 2.months) }

        it 'returns a list of pending jobs' do
          job_list = [job_one, job_two, job_three]
          expect(client.pending_jobs).to match_array(job_list)
        end
      end

      context 'when Client does not have pending jobs' do
        let(:job) do
          build(:job, :with_plumber, client: client, date: Time.zone.today - 2.days, status: :done)
            .tap { |job| job.save(validate: false) }
        end

        it 'returns an empty array' do
          expect(client.pending_jobs).to be_empty
        end
      end
    end
  end
end
