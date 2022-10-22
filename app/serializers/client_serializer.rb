# frozen_string_literal: true

class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :age, :address
end
