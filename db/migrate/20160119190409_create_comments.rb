class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :bar, null: false
      t.belongs_to :user, null: false
      t.string :description, null: false
      t.string :rating, null: false

      t.timestamps null: false
    end
    add_index :comments, [:bar_id, :user_id], unique: true
  end
end
