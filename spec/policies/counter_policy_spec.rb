require 'spec_helper'


describe CounterPolicy do
  subject { described_class }

  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:counter) { create(:counter) }

  permissions :new? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :create? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :edit? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :show? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :update? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :update? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end

  permissions :destroy? do
    it 'grants access if user is current_user' do
      counter.update_attribute(:user_id, user.id)
      expect(subject).to permit(user, counter)
    end
    it 'does not grants access if user is not current_user' do
      counter.update_attribute(:user_id, another_user.id)
      expect(subject).not_to permit(user, counter)
    end
  end
end
