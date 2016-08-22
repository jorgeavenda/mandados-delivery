class CreateCuadres < ActiveRecord::Migration
  def change
    create_table :cuadres do |t|
      t.datetime :start_date_at
      t.datetime :end_date_at

      t.timestamps null: false
    end
  end
end
