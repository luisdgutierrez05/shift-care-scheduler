# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobPlumber, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:job) }
    it { is_expected.to belong_to(:plumber) }
    it { is_expected.to accept_nested_attributes_for(:plumber) }
  end
end
