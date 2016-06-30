class CreateShoppingCart < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.belongs_to :buyer, index:true
      t.integer :status_cart, default: 1
      t.datetime :received_at

      t.timestamps null: false
    end
  end
end
