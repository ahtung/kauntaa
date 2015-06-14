Given(/^User home page$/) do
  create(:palette)
  @user = create(:user, :with_counters)
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
  sleep 3
  counter_value = first('.counter').first('.counter-value').native.all_text.to_i
  expect(counter_value).to eq(0)
end

Then(/^counter should have increased by (\d+)$/) do |increment|
  sleep 3
  counter_value = first('.counter').first('.counter-value').native.all_text.to_i
  expect(counter_value).to eq(increment.to_i)
end
