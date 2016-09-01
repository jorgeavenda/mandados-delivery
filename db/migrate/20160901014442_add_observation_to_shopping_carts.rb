class AddObservationToShoppingCarts < ActiveRecord::Migration
  def change
    add_column :shopping_carts, :observation, :string
  end
end
