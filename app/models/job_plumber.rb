# frozen_string_literal: true

# == Schema Information
#
# Table name: job_plumbers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  job_id     :bigint
#  plumber_id :bigint
#
# Indexes
#
#  index_job_plumbers_on_job_id      (job_id)
#  index_job_plumbers_on_plumber_id  (plumber_id)
#
class JobPlumber < ApplicationRecord
  attr_accessor :plumber_ids

  belongs_to :job
  belongs_to :plumber

  accepts_nested_attributes_for :plumber
end
