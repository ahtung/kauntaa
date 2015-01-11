# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User', js: true do
  before :each do
    @user = create(:user)
    login_as(@user)
  end

  it 'should be able to see a counted number in homepage' do
    visit user_root_path
    expect(counter_value).to eq("9 9 0 9 9 0")
  end

  it 'should be able to edit his/her counter name' do
    visit user_root_path
    click_on @user.counter.name
    fill_in 'counter_name', with: Faker::Lorem.sentence
    click_on 'Save'
    expect(page).to have_content("Counter was successfully updated.")
  end

  it 'should be able to edit his/her counter value' do
    visit user_root_path
    click_on @user.counter.name
    fill_in 'counter_value', with: rand(0..30)
    click_on 'Save'
    expect(page).to have_content("Counter was successfully updated.")
  end

  describe '' do
    it 'should be able to start counting from 0', focus: true do
      visit user_root_path
      click_on 'Count'
      sleep 1
      expect(counter_value).to eq("9 0 0 0 1 1")
    end

    it 'should be able to resume counting' do
      @user.counter.update_attribute(:value, 10)
      visit user_root_path
      click_on 'Count'
      sleep 1
      expect(counter_value).to eq("1 1 1 0 1 1")
    end
  end
end