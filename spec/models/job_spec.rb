require 'rails_helper'

RSpec.describe Job, type: :model do
  describe 'Attributes' do
    it { is_expected.to define_enum_for(:status).backed_by_column_of_type(:integer) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:client) }
    it { is_expected.to have_many(:job_plumbers) }
    it { is_expected.to have_many(:plumbers).through(:job_plumbers) }
    it { is_expected.to accept_nested_attributes_for(:job_plumbers) }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:client_id) }
  end

  describe 'Custom validations' do
    describe '#current_date_is_prenset_day?' do
      let(:client) { create(:client) }

      context 'when date is present day' do
        let(:job) { build(:job, client: client) }

        it 'returns true' do
          expect(job.valid?).to be_truthy
        end
      end

      context 'when date is not present day' do
        let(:job) { build(:job, date: Date.today - 1.days, client: client) }

        it 'returns false' do
          expect(job.valid?).to be_falsey
        end

        it 'displays an error message' do
          job.valid?
          job_error = job.errors.full_messages.join(', ')
          error_message = I18n.t('models.job.errors.date.in_past')

          expect(job_error).to eq(error_message)
        end
      end
    end
  end

  describe 'Delegations' do
    it { is_expected.to respond_to(:client_name) }
  end

  describe 'Instance methods' do
    describe '#plumber_list' do
      let(:job) { create(:job) }

      context 'when there are some plumbers' do
        let(:plumber_names) { ['Plumber A', 'Plumber B', 'Plumber C'] }

        before do
          plumber_names.each do |plumber_name|
            plumber = create(:plumber, name: plumber_name)
            job.plumbers << plumber
          end
        end

        it 'returns a list of plumber names' do
          plumber_list = plumber_names.join(', ')
          expect(job.plumber_list).to eq(plumber_list)
        end
      end

      context 'when there are not plumbers' do
        it 'returns an empty string' do
          expect(job.plumber_list).to be_empty
        end
      end
    end
  end
end
