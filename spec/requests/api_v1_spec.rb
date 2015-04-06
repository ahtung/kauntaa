require 'rails_helper'

describe API, type: :request do
  describe 'GET /api/v1/counters/:id' do
    it 'increments counter' do
      counter = create(:counter)
      get "/api/v1/counters/#{counter.id}"
      expect(response.body).to eq "true"
    end
  end
end