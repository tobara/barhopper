class AddPopularQueryToBars < ActiveRecord::Migration
  def up
    add_column :bars, :popular_query, :string
  end

  def down
    remove_column :bars, :popular_query, :string
  end
end
