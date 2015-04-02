require 'rails_helper'

RSpec.describe 'User', type: :feature, skip: true do
  let(:user) { create(:user) }
  before :each do
    login_as(user)
  end

  xit 'should be able to logout' do
    visit user_root_path
    within '.header-item' do
      click_on 'Logout'
    end
    expect(page).to have_content('Count anything')
  end
end
