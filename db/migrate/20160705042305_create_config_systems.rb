class CreateConfigSystems < ActiveRecord::Migration
  def change
    create_table :config_systems do |t|
      t.float :delivery_price
      t.float :min_total_cart
      t.float :min_quantity
      t.float :dispatch_margin_error

      t.timestamps null: false
    end
  end
end
