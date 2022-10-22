# frozen_string_literal: true

class Client < User

  # Validations
  validates :age, presence: true
  validates :private_note, presence: true
  validates :address, presence: true

  # Associations
  has_many :jobs
  has_many :plumbers, through: :jobs

  # List of pending jobs
  def pending_jobs
    jobs.where(status: :pending)
  end

  private

  # Overridden method since clients are not required to login - out of assignment scope
  def password_required?
    return false
  end
end
