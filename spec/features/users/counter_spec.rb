# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User', js: true do
  before :each do
    @user = create(:user)
    login_as(@user)
  end

  it 'should be able to see a counted number in homepage' do
    visit user_root_path
    expect(counter_value).to eq("99 00 99 00")
  end

  it 'should be able to edit his/her counter name' do
    visit user_root_path
    click_on @user.counter.name
    new_name = Faker::Lorem.sentence
    fill_in 'counter_name', with: new_name
    click_on 'Save'
    expect(page).to have_content(new_name)
  end

  it 'should be able to edit his/her counter value' do
    visit user_root_path
    click_on @user.counter.name
    new_value = 29
    fill_in 'counter_value', with: new_value
    click_on 'Save'
    expect(counter_value).to eq("11 22 88 99")
  end

  describe '' do
    it 'should be able to start counting from 0', focus: true do
      visit user_root_path
      click_on 'Count'
      sleep 1
      expect(counter_value).to eq("99 00 00 11")
    end

    it 'should be able to resume counting' do
      @user.counter.update_attribute(:value, 10)
      visit user_root_path
      click_on 'Count'
      sleep 1
      expect(counter_value).to eq("11 11 00 11")
    end
  end
end