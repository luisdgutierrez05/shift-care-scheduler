# frozen_string_literal: false

require 'rails_helper'

RSpec.describe ClientSerializer, type: :serializer do
  let(:client) { build(:client) }

  subject { described_class.new(client) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys).to contain_exactly(:id, :name, :email, :age, :address)
  end
end
