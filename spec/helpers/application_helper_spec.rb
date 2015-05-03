require 'rails_helper'

describe ApplicationHelper do
  describe '#height_for(n)' do
    it 'returns 100 if n = 0' do
      expect(helper.height_for(0)).to eq(100)
    end

    it 'returns 100 if n = 1' do
      expect(helper.height_for(1)).to eq(100)
    end

    it 'returns 50 if n = 2' do
      expect(helper.height_for(2)).to eq(50)
    end

    it 'returns 50 if n = 3' do
      expect(helper.height_for(3)).to eq(50)
    end

    it 'returns 50 if n = 5' do
      expect(helper.height_for(5)).to eq(50)
    end

    it 'returns 33.33 if n = 8' do
      expect(helper.height_for(8)).to eq(33.333333333333336)
    end

    it 'returns 25 if n = 13' do
      expect(helper.height_for(13)).to eq(25)
    end

    it 'returns 20 if n = 21' do
      expect(helper.height_for(21)).to eq(20)
    end

    it 'returns 16.66 if n = 34' do
      expect(helper.height_for(34)).to eq(16.666666666666668)
    end
  end
end
