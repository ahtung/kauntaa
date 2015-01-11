# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User' do
  before :each do
    @user = create(:user)
    login_as(@user)
  end

  it 'should be able to see a counted number in homepage' do
    visit root_path
    counter_value = @user.counter.value
    if !counter_value
      counter_value = 0
    end
    expect(page).to have_content("You have kauntaa'd #{counter_value} times so far")
  end

  it 'should be able to edit his/her counter' do
    visit root_path
    click_on 'Edit Counter'
    fill_in 'counter_name', with: Faker::Lorem.sentence
    click_on 'Save'
    expect(page).to have_content("Counter was successfully updated.")
  end

  describe '' do
    it 'should be able to start counting from 0' do
      visit user_root_path
      click_on 'Count'
      expect(page).to have_content('1 times')
    end

    it 'should be able to resume counting' do
      @user.counter.update_attribute(:value, 10)
      visit user_root_path
      click_on 'Count'
      expect(page).to have_content('11 times')
    end
  end
end