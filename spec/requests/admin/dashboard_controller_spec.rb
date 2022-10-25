# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  login_admin_user

  describe 'GET #index' do
    before do
      create(:client, :with_two_pending_jobs)
    end

    context 'all jobs by week range' do
      before do
        get :index
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'renders :index template' do
        expect(response).to render_template(:index)
      end

      it 'assigns jobs using the default filter params' do
        expect(assigns(:jobs)).not_to be_empty
      end
    end
  end
end
