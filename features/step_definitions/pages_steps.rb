When(/^I visit "(.*?)"$/) do |arg1|
  create(:palette)
  visit page_path(arg1)
end

Then(/^page should have "(.*?)"$/) do |arg1|
  expect(page).to have_content arg1
end

Given(/^Guest visit root path$/) do
  create(:palette)
  visit root_path
end

When(/^I click on "(.*?)"/) do |arg1|
  click_on arg1
end
