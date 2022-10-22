# frozen_string_literal: true

class Job < ApplicationRecord
  has_paper_trail

  # Enums
  enum :status, { pending: 0, done: 1 }, prefix: true, scopes: false, default: :pending

  # Validations
  validates :date, presence: true
  validates_with JobValidator

  # Associations
  belongs_to :client
  has_many :job_plumbers, class_name: 'JobPlumber'
  has_many :plumbers, through: :job_plumbers

  accepts_nested_attributes_for :job_plumbers, allow_destroy: true, reject_if: :reject_job_plumbers

  # Scopes
  scope :by_status, -> (status = :pending) { where(status: status) }
  scope :by_date_range, -> (start_date, end_date) {
    where('date >= :start_date AND date <= :end_date', start_date: start_date, end_date: end_date)
  }

  delegate :name, to: :client, prefix: true

  def plumber_list
    plumbers.pluck(:name).join(', ')
  end

  private

  def reject_job_plumbers(attributes)
    attributes[:plumber_id].blank?
  end
end
