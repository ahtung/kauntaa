Given(/^I have no counters$/) do
end

When(/^I add a counter$/) do
  first('.new-counter').click
  fill_form
end

Then(/^I should have a couter$/) do
  visit user_counters_path
  expect(page).to have_selector('.a-counter')
end

def fill_form

end