require 'rails_helper'

RSpec.describe UserEntity, type: :model do
  subject(:entity) { UserEntity }

  it { is_expected.to represent(:email) }
end
