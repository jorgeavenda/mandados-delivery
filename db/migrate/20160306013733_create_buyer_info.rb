class CreateBuyerInfo < ActiveRecord::Migration
  def change
    create_table :buyer_infos do |t|
      t.integer :buyer_id
      t.string  :first_name
      t.string  :last_name
      t.string  :phonenumber
      
      t.timestamps
    end
  end
end
