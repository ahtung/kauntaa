When(/^I add a counter$/) do
  save_and_open_page
  first('.add-counter').click
  fill_form
end

Then(/^I should have a couter$/) do
  expect(page).to have_selector('.a-counter')
end

When(/^I sign in with "(.*?)"$/) do |email|
  create(:palette)
  user = FactoryGirl.create(:user, email: email)
  login_as(user, scope: :user)
  visit user_root_path
end

def fill_form

end