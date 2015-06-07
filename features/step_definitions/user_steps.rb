Given(/^There is a palette$/) do
  create(:palette)
end

When(/^I add a counter$/) do
  first('.add-counter-link').trigger('click')
  fill_form
end

When(/^I edit a counter$/) do
  @old_counter = @user.counters.first
  find('.edit-counter').trigger('click')
  fill_form
end

Then(/^I should have two counters$/) do
  expect(page).to have_selector('.counter', count: 3)
end

Then(/^Counter name should have changed$/) do
  expect(@user.counters.first.name).not_to eq(@old_counter.name)
end

When(/^I sign in with "(.*?)"$/) do |email|
  create(:palette)
  @user = create(:user, :with_counters, email: email)
  login_as(@user, scope: :user)
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
