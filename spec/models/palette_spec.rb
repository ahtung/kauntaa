require 'rails_helper'

RSpec.describe Palette, type: :model do
  it { should has_many(:counters) }
end
