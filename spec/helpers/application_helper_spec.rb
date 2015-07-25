require 'rails_helper'

describe ApplicationHelper do
  describe "#colored_link_to" do
    it "returns colored link with parameters" do
      palette = create(:palette)
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
