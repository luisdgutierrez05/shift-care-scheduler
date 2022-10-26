# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ApiController, type: :request do
  let(:api_path) { '/api/v1/invalid-routes' }

  describe 'GET #index' do
    context 'when request is invalid' do
      it 'response successfully' do
        get api_path, params: {}

        expect(response).to have_http_status(:not_found)
        expect(json_response['message']).to eq(I18n.t('exceptions.invalid_route'))
      end
    end
  end
end
