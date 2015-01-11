require 'rails_helper'

RSpec.describe User, :type => :model do
  it { should have_one(:counter) }

  it '#build_counter' do
    user = FactoryGirl.create(:user)
    expect(user.counter).not_to be(nil)
  end
end
