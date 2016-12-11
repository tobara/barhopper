class RemovePopularTimesFromBars < ActiveRecord::Migration
  def up
    remove_column :bars, :popular_time, :string, default: 0
  end

  def down
    add_column :bars, :popular_time, :string, default: 0
  end
end
