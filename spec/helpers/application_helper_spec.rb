require 'rails_helper'

describe ApplicationHelper do
  describe "#colored_link_to" do
    it "returns colored link with parameters" do
      palette = FactoryGirl.create(:palette)
      parameters = [
        id: 'home-link',
        class: 'home-link',
        remote: true
      ]
      parameters.each do |key, value|
        helper.colored_link_to('Home', '/', {key: value, palette: palette}).should eq(link_to('Home', '/', style: "color: #{palette.text_color}", key: value))
      end
    end
  end
end
