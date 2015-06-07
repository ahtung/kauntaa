When(/^I add a counter$/) do
  first('.add-counter-link').trigger('click')
  fill_form
end

When(/^I edit a counter$/) do
  find('.a-counter .edit-counter').trigger('click')
  fill_form
end

Then(/^I should have two counters$/) do
  expect(page).to have_selector('.a-counter', count: 2)
end

When(/^I sign in with "(.*?)"$/) do |email|
  create(:palette)
  user = FactoryGirl.create(:user, email: email)
  login_as(user, scope: :user)
  visit user_root_path
end

def fill_form
  sleep 0.4
  counter = build(:counter)
  fill_in 'counter_value', with: "#{counter.value}"
  fill_in 'counter_name', with: "#{counter.name}"
  page.execute_script("document.getElementById('counter_palette_id').value = #{counter.palette.id}")
  first('.button').click
end
