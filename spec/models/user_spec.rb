require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:counters).dependent(:destroy) }

  it '#build_counter' do
    user = create(:user)
    expect(user.counters.count).to be(1)
  end

  describe '.find_for_google_oauth2' do
    it 'should create a new user if does not exist' do
      user = build(:user)
      User.find_for_google_oauth2(omniauth_hash(user.email, user.password), nil)
      expect(User.count).to be(1)
    end

    it 'should return user if exists' do
      user = create(:user)
      expect(User.find_for_google_oauth2(omniauth_hash(user.email, user.password), nil)).to eq(user)
    end
  end
end
