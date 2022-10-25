# frozen_string_literal: true

module Admin
  class ClientsController < ApplicationController
    before_action :set_client, only: %i[show edit update destroy]

    def index
      @clients = Client.all
    end

    def show; end

    def new
      @client = Client.new
    end

    def edit; end

    def create
      @client = Client.new(client_params)

      if @client.save
        redirect_to admin_client_url(@client), notice: I18n.t('controllers.clients.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @client.update(client_params)
        redirect_to admin_client_url(@client), notice: I18n.t('controllers.clients.update.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @client.destroy

      redirect_to admin_clients_url, notice: I18n.t('controllers.clients.destroy.success')
    end

    private

    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:name, :email, :age, :address, :private_note)
    end
  end
end
