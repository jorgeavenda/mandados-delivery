class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.belongs_to :cities, index:true

      t.timestamps null: false
    end
  end
end
