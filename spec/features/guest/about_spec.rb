require 'rails_helper'

describe 'Guest' do
  before :each do
    visit guest_root_path
  end

  describe 'in navigation', js: true do
    it 'should see the number of users' do
      create_list(:user, 12)
      visit guest_root_path
      value = first('.counter').text.split(' ').last.to_i
      expect(page).to have_content(value)
    end

    it 'should see motto' do
      expect(page).to have_content('Count')
    end
  end

  it 'should see the product title' do
    expect(page).to have_content('Kauntaa')
  end

  it 'should see the product subtitle' do
    expect(page).to have_content('Count anything')
  end

  it 'should see a login button' do
    expect(page).to have_content('Sign in with Google')
  end
end