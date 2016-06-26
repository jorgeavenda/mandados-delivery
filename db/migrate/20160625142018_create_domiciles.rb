class CreateDomiciles < ActiveRecord::Migration
  def change
    create_table :domiciles do |t|
      t.integer :buyer_id
      t.belongs_to :delivery_route, index:true
      t.string :home

      t.timestamps null: false
    end
  end
end
