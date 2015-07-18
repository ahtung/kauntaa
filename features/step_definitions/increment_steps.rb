Given(/^User home page$/) do
  create(:palette)
  @user = create(:user, :with_counters)
  login_as(@user, scope: :user)
  visit user_root_path
end

When(/^I visit click to a counter$/) do
  find('.counter', match: :first).click
end

When(/^I click on a description of a counter$/) do
  sleep(1)
  within '.counters' do
    find('.edit-counter-link', match: :first).click
  end
  sleep(1)
  click_on 'Back'
end

Then(/^counter should not have changed$/) do
  within '.counters' do
    counter_value = first('.counter').first('.number h2').text.to_i
    expect(counter_value).to eq(0)
  end
end

Then(/^counter should have increased by (\d+)$/) do |increment|
  counter_value = first('.counter').first('.number h2').text.to_i
  expect(counter_value).to eq(increment.to_i)
end
