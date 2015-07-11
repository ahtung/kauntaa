Given(/^User home page$/) do
  create(:palette)
  @user = create(:user, :with_counters)
  login_as(@user, scope: :user)
  visit user_root_path
end

When(/^I visit click to a counter$/) do
  within "#chart" do
    find('.counter', match: :first).click
  end
end

When(/^I click on a description of a counter$/) do
  find('.edit-counter', match: :first).click
end

Then(/^counter should not have changed$/) do
  within "#chart" do
    counter_value = find('.counter-value', match: :first).text.to_i
    expect(counter_value).to eq(0)
  end
end

Then(/^counter should have increased by (\d+)$/) do |increment|
  within '#chart' do
    counter_value = first('.counter').first('.counter-value').text.to_i
    expect(counter_value).to eq(increment.to_i)
  end
end
