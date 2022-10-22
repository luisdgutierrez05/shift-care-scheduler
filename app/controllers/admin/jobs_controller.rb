# frozen_string_literal: true

module Admin
  class JobsController < ApplicationController
    def new
      @job = Job.new
      @job.job_plumbers << JobPlumber.new
    end

    def create
      @job = Job.new(job_params)

      if @job.save
        redirect_to admin_dashboard_index_path, notice: I18n.t('controllers.jobs.create.success')
      else
        render :new, status: :unprocessable_entity
      end
    end

    private

    def job_params
      params.require(:job).permit(:description, :date, :client_id, plumber_ids: [])
    end
  end
end
