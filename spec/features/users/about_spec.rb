require 'rails_helper'

describe 'User', skip: true do
  before :each do
    user = create(:user)
    login_as user
  end

  it 'should see a link to the about page' do
    visit user_root_path
    page.should have_selector('.about-link')
  end

  context 'on about page' do
    before :each do
      visit pages_about_path
    end

    it 'should see the product title' do
      expect(page).to have_content('Kauntaa')
    end

    it 'should see the product subtitle' do
      expect(page).to have_content('Count anything')
    end
  end
end
