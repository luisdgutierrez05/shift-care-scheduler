# frozen_string_literal: true

class JobPlumber < ApplicationRecord
  attr_accessor :plumber_ids

  belongs_to :job
  belongs_to :plumber

  accepts_nested_attributes_for :plumber
end
