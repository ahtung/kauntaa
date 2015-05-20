FactoryGirl.define do
  factory :palette do
    foreground_color { format('%06x', (rand * 0xffffff)) }
    background_color { format('%06x', (rand * 0xffffff)) }
    text_color { format('%06x', (rand * 0xffffff)) }
  end
end
