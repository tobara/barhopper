class AddBarImgToBars < ActiveRecord::Migration
  def change
    add_column :bars, :bar_img, :string
  end
end
