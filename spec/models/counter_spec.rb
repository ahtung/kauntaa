require 'rails_helper'

RSpec.describe Counter, type: :model do
  it { should belong_to(:user) }
end
