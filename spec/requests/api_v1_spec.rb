require 'rails_helper'

RSpec.describe API, type: :request do
  let!(:user) { create(:user, :with_counters) }

  context 'unauthenticated user' do
    describe 'GET /api/v1/me/counters/:id' do
      it 'redirects' do
        get "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end

    describe 'GET /api/v1/me/counters' do
      it 'redirects' do
        get '/api/v1/me/counters', format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end

    describe 'GET /api/v1/me/counters/:id/increment' do
      it 'redirects' do
        get "/api/v1/me/counters/#{user.counters.first.id}/increment", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end

    describe 'PATCH /api/v1/me/counters/:id' do
      xit 'redirects' do
        patch "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end

    describe 'POST /api/v1/me/counters/:id' do
      xit 'redirects' do
        post "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.body).to include 'You need to sign in or sign up before continuing'
      end
    end
  end

  context 'authenticated user' do
    before :each do
      post user_session_path, user: { email: user.email, password: user.password }
    end

    describe 'GET /api/v1/me/counters/:id' do
      it "returns user's counter" do
        get "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.status).to eq 200
      end
    end

    describe 'GET /api/v1/me/counters' do
      it "Lists user's counters" do
        get '/api/v1/me/counters', format: :json
        expect(response.status).to eq 200
      end
    end

    describe 'GET /api/v1/me/counters/:id/increment' do
      it "Increment user's counter" do
        get "/api/v1/me/counters/#{user.counters.first.id}/increment", format: :json
        expect(response.status).to eq 200
      end
    end

    describe 'PATCH /api/v1/me/counters/:id' do
      it "updates user's counter" do
        patch "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.status).to eq 200
      end
    end

    describe 'POST /api/v1/me/counters/:id' do
      it 'creates user counter' do
        post "/api/v1/me/counters/#{user.counters.first.id}", format: :json
        expect(response.status).to eq 200
      end
    end
  end
end
