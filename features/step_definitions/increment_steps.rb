Given(/^User home page$/) do
  create(:palette)
  user = FactoryGirl.create(:user, email: 'dunyakirkali@gmail.com')
  @counter = create(:counter, user_id: user.id)
  login_as(user, scope: :user)
  visit user_root_path
end

When(/^I visit click to a counter$/) do
  first('.a-counter').click
end

Then(/^counter should have increased by "(.*?)"$/) do |arg1|
  expect{current_user.counters.first.value}.to eq(@counter.value + 1)
end