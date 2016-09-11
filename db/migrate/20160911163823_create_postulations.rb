class CreatePostulations < ActiveRecord::Migration
  def change
    create_table :postulations do |t|
      t.text :address
      t.text :comment
      t.string :email
      t.integer :status_postulation, default: 1
      t.string :motive

      t.timestamps null: false
    end
  end
end
