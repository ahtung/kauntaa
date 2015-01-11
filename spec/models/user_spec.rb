require 'rails_helper'

RSpec.describe User, type: :model do

  describe '.find_for_google_oauth2' do
    it 'should create a new user if does not exist' do
      user = build(:user)
      google_response = OmniAuth::AuthHash.new({
        provider: 'google',
        uid: '1337',
        info: {
          email: user.email,
          password: user.password
        }
      })
      User.find_for_google_oauth2(google_response, nil)
      expect(User.count).to be(1)
    end

    it "should return user if exists" do
      user = create(:user)
      google_response = OmniAuth::AuthHash.new({
        provider: 'google',
        uid: '1337',
        info: {
          email: user.email,
          password: '123$%^asd.'
        }
      })
      expect(User.find_for_google_oauth2(google_response, nil)).to eq(user)
    end
  end
end
