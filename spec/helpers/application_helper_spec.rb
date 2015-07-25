require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#colored_link_to' do
    let(:palette) { create(:palette) }
    it "returns colored link with parameters id eq home-link" do
      expect(
        helper.colored_link_to('Home', '/',{ id: 'home-link', palette: { text_color: palette.text_color, foreground_color: palette.foreground_color } })
      ).to eq(
        link_to('Home', '/', style: "color: #{palette.text_color}; background-color: #{palette.foreground_color};", id: "home-link")
      )
    end

    it "returns colored link with parameters class eq home-link" do
      expect(
        helper.colored_link_to('Home', '/',{ class: 'home-link', palette: { text_color: palette.text_color, foreground_color: palette.foreground_color } })
      ).to eq(
        link_to('Home', '/', class: "home-link", style: "color: #{palette.text_color}; background-color: #{palette.foreground_color};")
      )
    end

    it "returns colored link with parameters remote eq true" do
      expect(
        helper.colored_link_to('Home', '/',{ remote: true, palette: { text_color: palette.text_color, foreground_color: palette.foreground_color } })
      ).to eq(
        link_to('Home', '/', style: "color: #{palette.text_color}; background-color: #{palette.foreground_color};", remote: true)
      )
    end
  end
end
