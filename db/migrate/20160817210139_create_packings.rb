class CreatePackings < ActiveRecord::Migration
  def change
    create_table :packings do |t|
      t.belongs_to :shopping_cart, index:true
      t.integer :packing_type, default: 0
      t.integer :quantity, default: 0

      t.timestamps null: false
    end
  end
end
