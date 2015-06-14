Given(/^User home page$/) do
  create(:palette)
  @user = FactoryGirl.create(:user)
  @user.counters.first.update_attribute(:value, 1)
  login_as(@user, scope: :user)
  visit user_root_path
end

When(/^I visit click to a counter$/) do
  first('.counter').trigger('click')
end


When(/^I click on a description of a counter$/) do
  first('.edit-counter').trigger('click')
end

Then(/^counter should not have changed$/) do
  counter_value = first('.counter-value').text
  expect(counter_value).to eq(0)
end

Then(/^counter should have increased by (\d+)$/) do |increment|
  counter_value = first('.counter-value').text
  expect(counter_value).to eq(increment.to_i)
end
