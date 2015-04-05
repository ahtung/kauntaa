require 'rails_helper'

describe 'counter:colorize' do
  include_context 'rake'

  its(:prerequisites) { should include('environment') }

  it 'generates a registrations report' do
    counter = create(:counter)
    before_palette = counter.palette
    subject.invoke
    counter.reload
    expect(counter.palette).not_to be(before_palette)
  end
end
