# frozen_string_literal: false

require 'rails_helper'

RSpec.describe JobSerializer, type: :serializer do
  let(:job) { create(:job) }

  subject { described_class.new(job) }

  it 'includes the expected attributes' do
    expect(subject.attributes.keys).to contain_exactly(:id, :status, :description, :date)
  end
end
