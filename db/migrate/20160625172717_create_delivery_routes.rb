class CreateDeliveryRoutes < ActiveRecord::Migration
  def change
    create_table :delivery_routes do |t|
      t.belongs_to :urbanization, index:true
      t.belongs_to :residential, index:true
      t.belongs_to :building, index:true
      t.string :addres
      t.string :delivery_time

      t.timestamps null: false
    end
  end
end
