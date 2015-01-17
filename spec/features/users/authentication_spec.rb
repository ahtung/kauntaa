require 'rails_helper'

RSpec.describe 'User', type: :feature do
  let(:user) { create(:user) }
  before :each do
    login_as(user)
  end

  it 'should be able to logout' do
    visit user_root_path
    click_on 'Logout'
    expect(page).to have_content('Count anything')
  end

end