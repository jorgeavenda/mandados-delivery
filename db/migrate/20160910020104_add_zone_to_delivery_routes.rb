class AddZoneToDeliveryRoutes < ActiveRecord::Migration
  def change
    add_reference :delivery_routes, :zone, index: true
    add_reference :delivery_routes, :office, index: true
    add_column :delivery_routes, :other, :boolean, default: false
  end
end
