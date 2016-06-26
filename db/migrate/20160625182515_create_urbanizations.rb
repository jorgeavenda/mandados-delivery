class CreateUrbanizations < ActiveRecord::Migration
  def change
    create_table :urbanizations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
