Given(/^There is a palette$/) do
  create(:palette)
end

When(/^I click on sign out$/) do
  find('.sign-out', match: :first).click
end

When(/^I add a counter$/) do
  find('.add-counter-link', match: :first).click
  fill_form
end

When(/^I click on Delete$/) do
  within '.edit-counter' do
    accept_alert do
      find('#delete-button', match: :first).click
    end
  end
end

When(/^I add a counter without name$/) do
  find('.add-counter-link', match: :first).click
  within('#new_counter') do
    find('input[type="submit"]', match: :first).click
  end
end

When(/^I edit a counter$/) do
  find('.edit-counter-link', match: :first).click
  @counter = Counter.first
end

When(/^I fill counter form$/) do
  fill_form
end

When(/^I fill counter form without name$/) do
  fill_form_without_name
end

Then(/^I should have a new counter$/) do
  within '.counters' do
    expect(page).to have_selector('.counter', count: 2)
  end
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

Then(/^Counter should be deleted$/) do
  expect(page).not_to have_content(@counter.name)
end

def fill_form_without_name
  @new_counter = build(:counter)
  fill_in 'counter_value', with: @new_counter.value
  fill_in 'counter_name', with: nil
  page.execute_script("document.getElementById('counter_palette_id').value = #{@new_counter.palette.id}")
  first('.button').click
end

def fill_form
  within '#chart' do
    @new_counter = build(:counter)
    fill_in 'counter_value', with: @new_counter.value
    fill_in 'counter_name', with: @new_counter.name
    page.execute_script("document.getElementById('counter_palette_id').value = #{@new_counter.palette.id}")
    first('.button').click
  end
end
