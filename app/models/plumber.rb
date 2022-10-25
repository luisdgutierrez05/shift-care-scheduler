# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  age                    :integer
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           not null
#  private_note           :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("Plumber"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
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
