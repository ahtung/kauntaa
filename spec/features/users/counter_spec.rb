# spec/features/client/post_spec.rb
require 'rails_helper'

describe 'User' do
  before :each do
    @user = FactoryGirl.create(:user)
    visit root_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    click_on 'Log in'
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
end