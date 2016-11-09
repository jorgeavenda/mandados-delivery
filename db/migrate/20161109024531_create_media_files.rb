class CreateMediaFiles < ActiveRecord::Migration
  def change
    create_table :media_files do |t|
      t.string :name
      t.string :description
      t.integer :media_type, default: 0

      t.timestamps null: false
    end
  end
end
