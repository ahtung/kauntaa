class AddUserIdToCounters < ActiveRecord::Migration
  def change
    add_column :counters, :user_id, :integer
  end
end
