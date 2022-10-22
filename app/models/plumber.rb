# frozen_string_literal: true

class Plumber < User
  serialize :vehicles

  # Validations
  validates :address, presence: true

  # Associations
  has_many :job_plumbers, class_name: 'JobPlumber'
  has_many :jobs, through: :job_plumbers
  has_many :clients, through: :jobs

  accepts_nested_attributes_for :job_plumbers

  # Overridden method since plumbers are not required to login - out of assignment scope
  def password_required?
    return false
  end
end
