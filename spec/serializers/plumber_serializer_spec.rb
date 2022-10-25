# frozen_string_literal: false

require 'rails_helper'

RSpec.describe PlumberSerializer, type: :serializer do
  let(:plumber) { create(:plumber) }

  subject { described_class.new(plumber) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys).to contain_exactly(:id, :name, :email, :address)
  end
end
