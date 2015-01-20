
RSpec.shared_examples "create counter" do |counter, expected_count|
  it '' do
    click_on 'new'
    fill_in 'counter_name', with: 'Dunya'
    click_on 'Save'
    expect(page).to have_selector('.counter', count: expected_count)
  end
end

RSpec.shared_examples "read counter" do
  xit '' do
    # click_on 'new'
    # fill_in 'counter_name', with: 'Dunya'
    # click_on 'Save'
    # expect(page).to have_selector('.counter', count: expected_count)
  end
end

RSpec.shared_examples "increment counter" do |expected_value|
  it '' do
    within "[data-counter-id='#{subject.id}']" do
      first('.increment-button').trigger 'click'
    end
    sleep 1
    value = 0
    within "[data-counter-id='#{subject.id}']" do
      value = first('.counter').text.split(' ').last.to_i
    end
    expect(value).to eq(expected_value)
  end
end

RSpec.shared_examples "decrement counter" do |expected_value|
  it '' do
    within "[data-counter-id='#{subject.id}']" do
      first('.decrement-button').trigger 'click'
    end
    sleep 1
    value = 0
    within "[data-counter-id='#{subject.id}']" do
      value = first('.counter').text.split(' ').last.to_i
    end
    expect(value).to eq(expected_value)
  end
end

RSpec.shared_examples "update counter" do |attribute, expected_value|
  it '' do
    first("[data-counter-id='#{subject.id}'] a.edit-counter").click
    fill_in "counter_#{attribute}", with: expected_value
    click_on 'Save'
    visit edit_user_counter_path(subject.user.id, subject.id)
    expect(page).to have_content(expected_value)
  end
end

RSpec.shared_examples "delete counter" do |expected_count|
  it '' do
    first("[data-counter-id='#{subject.id}'] a.edit-counter").click
    click_on 'x'
    expect(page).to have_selector('.counter', count: expected_count)
  end
end