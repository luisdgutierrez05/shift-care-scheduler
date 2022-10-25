# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobsFilterService, type: :service do
  describe '#call' do
    subject { described_class.new(filter_params) }

    let!(:client) { create(:client, :with_two_pending_jobs) }

    context 'when there are no filter params' do
      let(:filter_params) { {} }

      it 'filters by default per current week range and status pending' do
        expect(subject.call.count).to eq(2)
      end
    end

    context 'when there are filter params' do
      let(:current_plumber) { Plumber.first }

      before do
        client.jobs << create(:job, :with_specific_plumber, plumber: current_plumber, client: client)
      end

      context 'with plumber_id' do
        let(:filter_params) { { plumber_id: current_plumber.id } }

        it 'filters by current filter params' do
          expect(subject.call.count).to eq(current_plumber.jobs.count)
        end
      end

      context 'with date range' do
        let(:filter_params) do
          {
            start_date: Time.zone.today + 2.days,
            end_date: Time.zone.today + 2.days
          }
        end

        it 'filters by current filter params' do
          expect(subject.call.count).to eq(1)
        end
      end

      context 'with no plumber param' do
        let(:filter_params) do
          {
            start_date: Time.zone.today,
            end_date: Time.zone.today + 2.days,
            status: 'pending'
          }
        end

        it 'filters by current filter params' do
          expect(subject.call.count).to eq(3)
        end
      end
    end

    context 'when status param is invalid' do
      it 'raises CustomExceptions::InvalidStatusError error' do
        error_message = I18n.t('exceptions.invalid_job_status')

        expect do
          described_class.new({ status: 'invalid status' }).call
        end.to raise_error CustomExceptions::InvalidStatusError, error_message
      end
    end
  end
end
