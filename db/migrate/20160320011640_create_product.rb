class CreateProduct < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :description
      t.float :price
      t.string :image
      t.float :stock, default: 0
      t.float :stock_min, default: 0
      t.float :stock_max, default: 0
      t.integer :measuring_type, default: 0
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
