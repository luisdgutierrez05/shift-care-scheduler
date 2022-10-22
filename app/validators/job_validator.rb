# frozen_string_literal: true

# Class to validate date attribute into a Job instance.
class JobValidator < ActiveModel::Validator

  # Validates job information.
  def validate(record)
    @record = record

    current_date_in_prenset_day?
    no_job_pending?
  end

  private

  # Validates if date is in the past
  # @returns [Boolean] true/false
  def current_date_in_prenset_day?
    return true if @record.date.present? && @record.date >= Date.today

    error_message = I18n.t('models.job.errors.date.in_past')
    add_error_record(error_message)
  end

  # Validates if there is a current job pending
  # @returns [Boolean] true/false
  def no_job_pending?
    return true if @record.client&.pending_jobs&.empty?

    error_message = I18n.t('models.job.errors.status.pending')
    add_error_record(error_message)
  end

  # Adds error to record instance.
  # @params error_message [String] Error message.
  # @returns [Boolean] true/false
  def add_error_record(error_message)
    return if error_message.nil?

    @record.errors.add(:base, error_message)
  end
end
