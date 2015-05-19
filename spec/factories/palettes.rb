FactoryGirl.define do
  factory :palette do
    foreground_color { "%06x" % (rand * 0xffffff) }
    background_color { "%06x" % (rand * 0xffffff) }
    text_color { "%06x" % (rand * 0xffffff) }
  end
end
