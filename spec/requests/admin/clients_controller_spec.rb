# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ClientsController, type: :controller do
  login_admin_user

  let(:client) { create(:client) }

  describe 'GET index' do
    before do
      create_list(:client, 2)

      get :index
    end

    it 'has a 200 status code' do
      expect(response.status).to eq(200)
    end

    it 'renders :index template' do
      expect(response).to render_template(:index)
    end

    it 'assigns all clients' do
      expect(assigns(:clients)).not_to be_empty
    end
  end

  describe 'GET #show' do
    before do
      get :show, params: { id: client.id }
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

      it 'assigns client in the views' do
        expect(assigns(:client)).to be_a_new(Client)
      end
    end
  end

  describe 'GET #edit' do
    before do
      get :edit, params: { id: client.id }
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
      let(:params) { { client: FactoryBot.attributes_for(:client) } }

      before do
        post :create, params: params
      end

      it 'redirects to dashboard after created' do
        expect(response).to redirect_to(admin_client_url(assigns(:client)))
      end

      it 'returns a flash message' do
        expect(flash[:notice]).to eq(I18n.t('controllers.clients.create.success'))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          client: {
            name: nil,
            email: nil,
            age: 0,
            private_note: '',
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
        put :update, params: { id: client.id, client: update_params }
      end

      let(:update_params) { FactoryBot.attributes_for(:client).slice(:private_note, :address) }

      it 'updates client info' do
        client.reload

        update_params.keys.each do |key|
          expect(client.attributes[key.to_s]).to eq(update_params[key])
        end
      end

      it 'redirects to client page after updated' do
        expect(response).to redirect_to(admin_client_url(client))
      end
    end

    context 'with invalid params' do
      before do
        put :update, params: { id: client.id, client: update_params }
      end

      let(:update_params) { { private_note: nil, address: '' } }

      it 'returns a validation failure message' do
        expect(response).to have_http_status(422)
      end

      it 'renders to :edit template again' do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys and redirects to clients page after destroy' do
      expect {
        delete :destroy, params: { id: client.id }
      }.to change(Client, :count).by(0)
    end
  end
end
