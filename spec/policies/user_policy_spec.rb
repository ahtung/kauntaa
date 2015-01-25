require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  permissions :update? do
    it "grants access if user is current_user" do
      expect(subject).to permit(user, user)
    end
    it "does not grants access if user is not current_user" do
      expect(subject).not_to permit(user, another_user)
    end
  end

  permissions :destroy? do
    it "grants access if user is current_user" do
      expect(subject).to permit(user, user)
    end
    it "does not grants access if user is not current_user" do
      expect(subject).not_to permit(user, another_user)
    end
  end
end