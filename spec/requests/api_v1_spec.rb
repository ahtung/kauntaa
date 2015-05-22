require 'rails_helper'

describe API, type: :request do
  describe 'GET /api/v1/counters/:id' do
    it 'increments counter' do
      counter = create(:counter)
      get "/api/v1/counters/#{counter.id}"
      expect(response.body).to eq 'true'
    end
  end

  describe 'GET /api/v1/users/:user_id/counters' do
    xit "lists user's counter" do
      user = create(:user, :with_counters)
      get "/api/v1/users/#{user.id}/counters"
      expect(response.body).to match_array(user.counters)
    end
  end
end
