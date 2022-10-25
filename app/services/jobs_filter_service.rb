# frozen_string_literal: true

class JobsFilterService
  attr_reader :plumber, :start_date, :end_date, :status, :params

  def initialize(params = {})
    @params = params
    @plumber = find_plumber(params[:plumber_id])
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @status = params[:status]
  end

  def call
    filtered_jobs
  end

  private

  def find_plumber(plumber_id)
    Plumber.find_by(id: plumber_id)
  end

  def all_jobs_by_default_params
    Job.by_current_week.by_status
  end

  def date_range_exist?
    start_date.present? && end_date.present?
  end

  def filter_jobs_by_date_range(jobs)
    jobs.by_date_range(start_date, end_date)
  end

  def valid_status?
    Job.statuses.keys.include?(status)
  end

  def filter_jobs_by_status(jobs)
    raise_invalid_status_exception unless valid_status?

    jobs.by_status(status)
  end

  def filtered_jobs
    return all_jobs_by_default_params if params.empty?

    filtered_jobs = plumber.present? ? plumber.jobs : Job.all
    filtered_jobs = filter_jobs_by_date_range(filtered_jobs) if date_range_exist?
    filtered_jobs = filter_jobs_by_status(filtered_jobs) if status.present?

    filtered_jobs
  end

  # Raises invalid status error exception
  # @params exception [Error] exception object
  # @returns [CustomExceptions::InvalidStatusError] invalid status error exception
  def raise_invalid_status_exception
    exception = CustomExceptions::InvalidStatusError
    error_message = I18n.t('exceptions.invalid_job_status')
    raise exception, error_message
  end
end
