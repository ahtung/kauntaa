require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper, skip: true do
  describe '#colored_link_to' do
    let(:palette) { create(:palette) }

    parameters = [
      id: 'home-link',
      class: 'home-link',
      remote: true
    ]
    parameters.each do |key, value|
      it "returns colored link with parameters { #{key}, #{value} }" do
        expect(
          helper.colored_link_to('Home', '/', :"#{key}" => value, palette: palette)
          ).to eq(link_to('Home', '/', style: "color: #{palette.text_color}", :"#{key}" => value))
        end
      end
  end
end
