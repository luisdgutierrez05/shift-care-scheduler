# frozen_string_literal: true

class JobSerializer < ActiveModel::Serializer
  attributes :id, :status, :description, :date

  belongs_to :client
end
