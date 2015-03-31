class CreatePalettes < ActiveRecord::Migration
  def change
    create_table :palettes do |t|
      t.string :foreground_color
      t.string :background_color
      t.string :text_color

      t.timestamps null: false
    end
  end
end
