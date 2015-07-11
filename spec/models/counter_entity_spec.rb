require 'rails_helper'

RSpec.describe CounterEntity, type: :model do
  subject(:entity) { CounterEntity }

  it { is_expected.to represent(:id) }
  it { is_expected.to represent(:name) }
  it { is_expected.to represent(:value) }
  it { is_expected.to represent(:increment_url) }
  it { is_expected.to represent(:active_since) }
  xit { is_expected.to represent(:palette).using(PaletteEntity) }
  xit { is_expected.to represent(:user).using(UserEntity) }
end
