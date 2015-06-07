Given(/^User home page$/) do
  create(:palette)
  @user = FactoryGirl.create(:user)
  @user.counters.first.update_attribute(:value, 1)
  login_as(@user, scope: :user)
  visit user_root_path
end

When(/^I visit click to a counter$/) do
  first('.a-counter').trigger('click')
end

# Then(/^counter should have increased by 1$/) do
#   expect(@user.counters.first.value).to eq(2)
# end

When(/^I click on a description of a counter$/) do
  save_and_open_page
  find('.a-counter').trigger('click')
end

Then(/^counter should not have changed$/) do
  expect(@user.counters.first.value).to eq(1)
end
