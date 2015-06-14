# PaletteEntity
class PaletteEntity < Grape::Entity
  expose :background_color
  expose :foreground_color
  expose :text_color
end
