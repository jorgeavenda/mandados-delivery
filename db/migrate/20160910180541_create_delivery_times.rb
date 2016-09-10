class CreateDeliveryTimes < ActiveRecord::Migration
  def change
    create_table :delivery_times do |t|
      t.string :delivery_hours
      t.string :max_time_received
      t.belongs_to :zone, index:true

      t.timestamps null: false
    end
  end
end
