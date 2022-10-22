# frozen_string_literal: true

module Api
  module V1
    class JobsController < ApiController
      before_action :find_job, only: %i[update]

      def index
        jobs = JobsFilterService.new(job_params).call
        json_response(jobs, :ok)
      end

      def update
        @job.update!(status: :done) if @job.status_pending?
        json_response(@job)
      end

      private

      def find_job
        @job = Job.find(params[:id])
      end

      def job_params
        params.require(:data).require(:attributes).permit(:plumber_id, :start_date, :end_date, :status)
      end
    end
  end
end
