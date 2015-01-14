require 'rails_helper'

RSpec.describe Counter, type: :model do
  it { should belong_to(:user) }


  it '#editable_attributes' do
    counter = create(:counter)
    expect(counter.editable_attributes).to match_array(%w(name value))
  end
end
