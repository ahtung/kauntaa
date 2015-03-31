class AddPaletteIdToCounters < ActiveRecord::Migration
  def change
    add_column :counters, :palette_id, :integer
  end
end
