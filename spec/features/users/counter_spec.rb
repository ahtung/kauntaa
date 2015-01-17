# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User', js: true do
  let(:user) { create(:user) }
  before :each do
    login_as(user)
  end

  it 'should be able to see a counted number in homepage' do
    visit user_root_path
    expect(counter_value).to eq("0")
  end

  it 'should be able to add a new counter' do
    visit user_root_path
    click_on 'new'
    fill_in 'counter_name', with: 'Dunya'
    click_on 'Save'
    expect(counter_value).to eq("0")
  end

  it 'should be able to delete a counter' do
    visit user_root_path
    first("[data-counter-id='#{user.counters.first.id}'] a").click
    click_on 'delete'
    expect(find('.counter').length).to eq(1)
  end

  describe 'should be able to edit his/her counter' do
    before :each do
      visit user_root_path
      first("[data-counter-id='#{user.counters.first.id}'] a").click
    end

    it 'name' do
      fill_in 'counter_name', with: 'Dunya'
      click_on 'Save'
      expect(page).to have_content('Dunya')
    end

    it 'value' do
      fill_in 'counter_value', with: 99
      click_on 'Save'
      expect(page).to have_content('9 9')
    end
  end

  describe '' do
    it 'should be able to start counting from 0' do
      visit user_root_path
      within "[data-counter-id='#{user.counters.first.id}']" do
        first('.counter-button').click
      end
      sleep 1
      expect(counter_value).to eq("0 1")
    end

    it 'should be able to resume counting' do
      user.counters.first.update_attribute(:value, 10)
      visit user_root_path
      within "[data-counter-id='#{user.counters.first.id}']" do
        first('.counter-button').click
      end
      sleep 1
      expect(counter_value).to eq("1 0 1")
    end

    it 'should be able to count 2 seperate things' do
      user.counters << create(:counter)
      visit user_root_path
      within "[data-counter-id='#{user.counters.first.id}']" do
        first('.counter-button').click
      end
      sleep 1
      within "[data-counter-id='#{user.counters.first.id}']" do
        expect(counter_value).to eq("0 1")
      end
      within "[data-counter-id='#{user.counters.last.id}']" do
        expect(counter_value).to eq("2 9")
      end
    end
  end
end