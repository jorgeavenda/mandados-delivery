class AddImageToProducts < ActiveRecord::Migration
  def self.up
    add_attachment :products, :imageproduct
  end

  def self.down
    remove_attachment :products, :imageproduct
  end
end
