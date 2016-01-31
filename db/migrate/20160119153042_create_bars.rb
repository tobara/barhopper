class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.belongs_to :user
      t.string :name, null: false, unique: true
      t.string :location, null: false
      t.string :address, null: false
      t.string :popular_time, default: 0

      t.timestamps null: false
    end
    add_index :bars, :name
  end
end
