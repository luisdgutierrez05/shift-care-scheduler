# frozen_string_literal: true

class PlumberSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :address
end
