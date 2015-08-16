require 'rails_helper'

RSpec.describe PaletteEntity, type: :model, skip: true do
  subject(:entity) { PaletteEntity }

  it { is_expected.to represent(:background_color) }
  it { is_expected.to represent(:foreground_color) }
  it { is_expected.to represent(:text_color) }
end
