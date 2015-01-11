require 'rails_helper'

describe 'Guest' do
  before :each do
    visit guest_root_path
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