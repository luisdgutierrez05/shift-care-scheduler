# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::JobsController, type: :controller do
  login_admin_user

  describe 'GET #new' do
    context 'redirects to the new form' do
      before do
        get :new
      end

      it 'renders to :new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns jobs with job_plumbers in the views' do
        expect(assigns(:job)).to be_a_new(Job)
        expect(assigns(:job).job_plumbers).not_to be_empty
      end
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:client) { create(:client) }
      let(:plumbers) { create_list(:plumber, 2) }
      let(:params) do
        {
          job: {
            description: 'Back yard issued reported with pests',
            date: Time.zone.today,
            client_id: client.id,
            plumber_ids: plumbers.pluck(:id)
          }
        }
      end

      before do
        post :create, params: params
      end

      it 'redirects to dashboard after created' do
        expect(response).to redirect_to(admin_dashboard_index_url)
      end

      it 'returns a flash message' do
        expect(flash[:notice]).to eq(I18n.t('controllers.jobs.create.success'))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          job: {
            description: '',
            date: nil,
            client_id: nil,
            plumber_ids: []
          }
        }
      end

      before do
        post :create, params: params
      end

      it 'returns a validation failure message' do
        expect(response).to have_http_status(422)
      end

      it 'renders to :new template again' do
        expect(response).to render_template(:new)
      end
    end
  end
end
