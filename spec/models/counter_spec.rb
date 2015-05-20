require 'rails_helper'

RSpec.describe Counter, type: :model do
  # Reations
  it { should belong_to(:user) }
  it { should belong_to(:palette) }

  # Instance methods
  describe '#' do
    it 'editable_attributes' do
      counter = create(:counter)
      expect(counter.editable_attributes).to match_array %w(name value)
    end

    describe 'clean_value' do
      it 'should return 0 if value nil' do
        counter = create(:counter, value: nil)
        expect(counter.clean_value).to eq 0
      end

      it 'should return value if value' do
        counter = create(:counter, value: 12)
        expect(counter.clean_value).to eq 12
      end
    end

    it 'set_creation_date' do
      counter = create(:counter)
      counter.created_at_date = '2015-11-05'
      counter.created_at_time = '00:00'
      counter.save
      expect(counter.created_at).to eq DateTime.zone.parse('2015-11-05 00:00')
    end

    it 'increment' do
      counter = create(:counter, value: 0)
      counter.increment
      expect(counter.value).to eq 1
    end
  end
end
