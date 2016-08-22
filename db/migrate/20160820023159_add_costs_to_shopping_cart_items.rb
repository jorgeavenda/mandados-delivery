class AddCostsToShoppingCartItems < ActiveRecord::Migration
  def change
    add_column :shopping_cart_items, :cost, :float, default: 0
  end
end
