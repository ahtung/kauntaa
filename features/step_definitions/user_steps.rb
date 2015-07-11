Given(/^There is a palette$/) do
  create(:palette)
end

When(/^I click on sign out$/) do
  find('.sign-out', match: :first).click
end

When(/^I add a counter$/) do
  find('.add-text', match: :first).click
  fill_form
end

When(/^I edit a counter$/) do
  first('.edit-counter').click
  fill_form
end

Then(/^I should have two counters$/) do
  pending
  expect(page).to have_selector('.counter', count: 2)
end

Then(/^Counter name should have changed$/) do
  expect(page).to have_content(@new_counter.name)
end

When(/^I sign in with "(.*?)"$/) do |email|
  create(:palette)
  @user = create(:user, :with_counters, email: email)
  login_as(@user, scope: :user)
  visit user_root_path
end

Then(/^I should have signed out/) do
  expect(page).to have_content('Sign in with Google')
end

def fill_form
  sleep 0.4
  @new_counter = build(:counter)
  fill_in 'counter_value', with: @new_counter.value
  fill_in 'counter_name', with: @new_counter.name
  page.execute_script("document.getElementById('counter_palette_id').value = #{@new_counter.palette.id}")
  first('.button').click
end
