class AddCostsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cost, :float, default: 0
  end
end
