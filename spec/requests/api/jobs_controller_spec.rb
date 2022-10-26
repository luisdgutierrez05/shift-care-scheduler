# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::JobsController, type: :request do
  let(:api_path) { '/api/v1/jobs' }

  let(:invalid_attributes) do
    {
      plumber_id: nil,
      start_date: nil,
      end_date: nil,
      status: 'wrong status'
    }
  end

  let!(:client) { create(:client, :with_two_pending_jobs) }

  describe 'GET #index' do
    context 'when params are empty' do
      let(:job_attributes) do
        {
          data: {
            attributes: {
              plumber_id: nil,
              start_date: '',
              end_date: '',
              status: ''
            }
          }
        }
      end

      before do
        get api_path, params: job_attributes
      end

      it 'response successfully' do
        expect(response).to have_http_status(:success)
        expect(response).to be_successful
      end

      it 'returns a list of jobs per current week and pending' do
        expect(json_response.count).to eq(Job.count)
      end
    end

    context 'when params are invalid' do
      let(:job_attributes) do
        {
          data: {
            attributes: invalid_attributes
          }
        }
      end

      it 'returns unprocessable entity error' do
        get api_path, params: job_attributes

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response.dig('error')).to eq('Unprocessable entity')
      end
    end

    context 'when params are malformed' do
      let(:job_attributes) do
        {
          data: {
            private_note: 'wrong attribute'
          }
        }
      end

      it 'returns a badd request error' do
        get api_path, params: job_attributes

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'when params are valid' do
      let(:new_client) { create(:client) }
      let(:job_attributes) do
        {
          data: {
            attributes: {
              status: 'done'
            }
          }
        }
      end

      before do
        create(:job, :with_plumber, :with_status_done, client: new_client)
        get api_path, params: job_attributes
      end

      it 'returns success response' do
        expect(response).to have_http_status(:success)
        expect(response).to be_successful
      end

      it 'returns one job with done status' do
        expect(json_response.count).to eq(1)
      end
    end
  end

  describe 'PUT #update' do
    let(:current_job) { client.jobs.first }

    context 'with valid job id' do
      it 'updates the resquested job' do
        put "#{api_path}/#{current_job.id}"

        expect(response).to have_http_status(:ok)
        expect(json_response['status']).to eq('done')
      end
    end

    context 'with invalid job id' do
      it 'returns a JSON response with validation errors' do
        put "#{api_path}/invalid-id"

        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
