require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "#colored_link_to" do
    let(:palette) { create(:palette) }

    it "returns colored link with parameters" do
      parameters = [
        id: "home-link",
        class: "home-link",
        remote: true
      ]
      parameters.each do |key, value|
        expect(helper.colored_link_to("Home", "/", {key: value, palette: palette})).to eq(link_to('Home', '/', style: "color: #{palette.text_color}", key: value))
      end
    end
  end
end
