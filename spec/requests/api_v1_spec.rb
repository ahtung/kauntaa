require 'rails_helper'

RSpec.describe API, type: :request do
  context 'unauthenticated user' do
    describe 'GET /api/v1/counters/:id' do
      it 'redirects' do
        counter = create(:counter)
        get "/api/v1/counters/#{counter.id}", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end

    describe 'GET /api/v1/users/:user_id/counters' do
      it "redirects" do
        user = create(:user, :with_counters)
        get "/api/v1/users/#{user.id}/counters", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end
  end

  context 'authenticated user' do
    let(:user) { create(:user, :with_counters) }

    before :each do
      post user_session_path, user: { email: user.email, password: user.password }
    end

    describe 'GET /api/v1/counters/:id' do
      it 'reirects' do
        get "/api/v1/counters/#{user.counters.first.id}", format: :json
        expect(response.body).to eq 'true'
      end
    end

    describe 'GET /api/v1/users/:user_id/counters' do
      it "lists user's counter" do
        get "/api/v1/users/#{user.id}/counters", format: :json
        expect(response.status).to eq 200
      end
    end
  end
end
