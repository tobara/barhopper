class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.belongs_to :user
      t.string :name, null: false, unique: true
      t.string :location, null: false
      t.string :address, null: false

      t.timestamps null: false
    end
    add_index :bars, :name
  end
end
