class CreateResidentials < ActiveRecord::Migration
  def change
    create_table :residentials do |t|
      t.string :name
      
      t.timestamps null: false
    end
  end
end
