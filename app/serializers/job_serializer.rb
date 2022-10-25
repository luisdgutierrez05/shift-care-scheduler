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
class JobSerializer < ActiveModel::Serializer
  attributes :id, :status, :description, :date

  belongs_to :client
end
