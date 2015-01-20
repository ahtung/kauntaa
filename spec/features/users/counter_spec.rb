# spec/features/client/counter_spec.rb
require 'rails_helper'

describe 'User', js: true do
  let(:user) { create(:user) }

  before :each do
    login_as(user)
  end

  context 'w/o a counter' do
    before :each do
      user.counters.delete_all
      visit user_root_path
    end

    it_behaves_like "create counter", 2
  end

  context 'w a counter' do
    subject { user.counters.first }

    context 'of value 0' do
      it_behaves_like 'create counter', 3
      it_behaves_like 'read counter'
      it_behaves_like 'increment counter', 1
      it_behaves_like 'decrement counter', 0
      it_behaves_like 'update counter', :name, 'Dunya'
      it_behaves_like 'update counter', :value, 99
      it_behaves_like 'delete counter', 1
    end
    context 'of value 5' do
      before :each do
        subject.update_attribute(:value, 5)
      end

      it_behaves_like 'create counter', 7
      it_behaves_like 'read counter'
      it_behaves_like 'increment counter', 6
      it_behaves_like 'decrement counter', 4
      it_behaves_like 'update counter', :name, 'Dunya'
      it_behaves_like 'update counter', :value, 99
      it_behaves_like 'delete counter', 5
    end
  end

  context 'w many counters'
end