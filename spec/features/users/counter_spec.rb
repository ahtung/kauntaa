# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User', js: true do
  before :each do
    @user = create(:user)
    @counter = build(:counter)
    login_as(@user)
  end

  it 'should be able to see a counted number in homepage' do
    visit user_root_path
    expect(counter_value).to eq("99 00 99 00")
  end

  it 'should be able to edit his/her counter name' do
    visit user_root_path
    click_on @user.counters.first.name
    fill_in 'counter_name', with: @counter.name
    click_on 'Save'
    expect(page).to have_content(@counter.name)
  end

  it 'should be able to edit his/her counter value' do
    visit user_root_path
    click_on @user.counters.first.name
    fill_in 'counter_value', with: @counter.value
    click_on 'Save'
    expect(counter_value).to eq("99 00 11 22")
  end

  describe '' do
    it 'should be able to start counting from 0' do
      visit user_root_path
      first('#counter-button').click
      sleep 1
      expect(counter_value).to eq("99 00 00 11")
    end

    it 'should be able to resume counting' do
      @user.counters.first.update_attribute(:value, 10)
      visit user_root_path
      first('#counter-button').click
      sleep 1
      expect(counter_value).to eq("99 00 88 99")
    end
  end
end