# spec/features/client/time_on_edit_spec.rb
require 'rails_helper'

describe 'User', js: true do
  let(:user) { create(:user, :with_counter_a_month_old) }

  before :each do
    login_as(user)
  end

  describe 'w a counter' do
    before :each do
      @timeago = time_ago_in_words(user.counters.first.created_at)
      @created_at = user.counters.first.created_at
      visit edit_user_counter_path(user, user.counters.first)
      fill_in 'counter_value', with: 5
      first('input[type=submit]').click
    end

    it 'should be able to edit it and have the time unchanged unles user set it' do
      user.reload
      expect(page).to have_content("#{@timeago}")
    end

    it 'should be able to edit it and have the time unchanged unles user set it' do
      expect(user.counters.first.created_at).to be(@created_at)
    end
  end
end