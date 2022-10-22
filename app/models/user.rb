# frozen_string_literal: true

class User < ApplicationRecord
  has_paper_trail

  devise :database_authenticatable, :recoverable, :validatable

  self.inheritance_column = 'role'

  # Validations
  validates :email, presence: true, allow_blank: false
  validates :email, uniqueness: true
  validates :name, presence: true, allow_blank: false
end
