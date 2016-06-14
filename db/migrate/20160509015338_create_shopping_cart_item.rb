class CreateShoppingCartItem < ActiveRecord::Migration
  def change
    create_table :shopping_cart_items do |t|
      t.belongs_to :shopping_cart, index:true
      t.belongs_to :product, index: true
      t.float :quantity, default: 0
      t.float :amount, default: 0
      t.float :dispatched, default: 0

      t.timestamps null: false
    end
  end
end
