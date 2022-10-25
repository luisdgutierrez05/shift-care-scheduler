# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::PlumbersController, type: :controller do
  login_admin_user

  let(:plumber) { create(:plumber) }

  describe 'GET index' do
    before do
      create_list(:plumber, 2)

      get :index
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns all plumbers' do
      expect(assigns(:plumbers)).not_to be_empty
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: plumber.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    context 'redirects to the new form' do
      before do
        get :new
      end

      it 'renders to :new template' do
        expect(response).to render_template(:new)
      end

      it 'assigns plumber in the views' do
        expect(assigns(:plumber)).to be_a_new(Plumber)
      end
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: plumber.id }
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      let(:params) { { plumber: FactoryBot.attributes_for(:plumber) } }

      before do
        post :create, params: params
      end

      it 'redirects to dashboard after created' do
        expect(response).to redirect_to(admin_plumber_url(assigns(:plumber)))
      end

      it 'returns a flash message' do
        expect(flash[:notice]).to eq(I18n.t('controllers.plumbers.create.success'))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          plumber: {
            name: nil,
            email: nil,
            address: ''
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

  describe 'PUT #update' do
    context 'with valid params' do
      before do
        put :update, params: { id: plumber.id, plumber: update_params }
      end

      let(:update_params) { FactoryBot.attributes_for(:plumber).slice(:name, :email) }

      it 'updates plumber info' do
        plumber.reload

        update_params.keys.each do |key|
          expect(plumber.attributes[key.to_s]).to eq(update_params[key])
        end
      end

      it 'redirects to plumber page after updated' do
        expect(response).to redirect_to(admin_plumber_url(plumber))
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: plumber.id, plumber: update_params }
      end

      let(:update_params) { { name: '', email: nil } }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(422)
      end

      it 'renders to :edit template again' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys and redirects to plumbers page after destroy' do
      expect {
        delete :destroy, params: { id: plumber.id }
      }.to change(Plumber, :count).by(0)
    end
  end
end
