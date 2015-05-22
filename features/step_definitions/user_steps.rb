When(/^I add a counter$/) do
  save_and_open_page
  first('.new-counter').click
  fill_form
end

Then(/^I should have a couter$/) do
  visit user_counters_path
  expect(page).to have_selector('.a-counter')
end

When(/^I sign in with "(.*?)"$/) do |email|
  create(:palette)
  user = FactoryGirl.create(:user, email: email)
  login_as(user, scope: :user)
  visit user_counters_path(user)
end

def fill_form

end