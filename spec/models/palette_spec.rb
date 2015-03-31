require 'rails_helper'

RSpec.describe Palette, type: :model do
  it { should have_many(:counters) }
end
