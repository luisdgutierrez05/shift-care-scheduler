# frozen_string_literal: true

module Admin
  class PlumbersController < ApplicationController
    before_action :set_plumber, only: %i[show edit update destroy]

    def index
      @plumbers = Plumber.all
    end

    def show; end

    def new
      @plumber = Plumber.new
    end

    def edit; end

    def create
      @plumber = Plumber.new(plumber_params)

      if @plumber.save
        redirect_to admin_plumber_url(@plumber), notice: I18n.t('controllers.plumbers.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @plumber.update(plumber_params)
        redirect_to admin_plumber_url(@plumber), notice: I18n.t('controllers.plumbers.update.success')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @plumber.destroy

      redirect_to admin_plumbers_url, notice: I18n.t('controllers.plumbers.destroy.success')
    end

    private

    def set_plumber
      @plumber = Plumber.find(params[:id])
    end

    def plumber_params
      params.require(:plumber).permit(:name, :email, :address)
    end
  end
end
