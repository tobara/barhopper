class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.belongs_to :bar, null: false
      t.string :day
      t.integer :hour
      t.integer :popularity
    end
  end
end
