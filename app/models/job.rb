# frozen_string_literal: true

# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  date        :date
#  description :text
#  status      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  client_id   :bigint           not null
#
# Indexes
#
#  index_jobs_on_client_id  (client_id)
#
# Foreign Keys
#
#  fk_rails_...  (client_id => users.id)
#
class Job < ApplicationRecord
  has_paper_trail

  # By default the allocated jobs will be filtered by period of current week
  DEFAULT_DATE_FILTERS = {
    start_date: Date.today.beginning_of_week,
    end_date: Date.today.end_of_week
  }.freeze

  # Enums
  enum :status, { pending: 0, done: 1 }, prefix: true, scopes: false, default: :pending

  # Validations
  validates :date, presence: true
  validates :description, presence: true
  validates :client_id, presence: true
  validates_with JobValidator

  # Associations
  belongs_to :client
  has_many :job_plumbers, class_name: 'JobPlumber'
  has_many :plumbers, through: :job_plumbers

  accepts_nested_attributes_for :job_plumbers, allow_destroy: true, reject_if: :reject_job_plumbers

  # Scopes
  scope :by_status, -> (status = 'pending') { where(status: status) }
  scope :by_date_range, -> (start_date, end_date) {
    where('date >= :start_date AND date <= :end_date', start_date: start_date, end_date: end_date)
  }
  scope :by_current_week, -> {
    by_date_range(DEFAULT_DATE_FILTERS[:start_date], DEFAULT_DATE_FILTERS[:end_date])
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
