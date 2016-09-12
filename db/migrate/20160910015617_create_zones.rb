class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.belongs_to :city, index:true
      t.float :delivery_price

      t.timestamps null: false
    end
  end
end
