class AddDatesToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :prepared_at, :datetime
    add_column :shopping_carts, :delivered_at, :datetime
    add_column :shopping_carts, :rejected, :datetime
    add_column :shopping_carts, :cashed_at, :datetime
  end
end
