class ShoppingCart < ActiveRecord::Base
  belongs_to :buyer

  has_many :shopping_cart_items
  has_many :products, through: :shopping_cart_items


  def remove_item(shopping_cart_item)
    self.shopping_cart_items.destroy(shopping_cart_item)
  end

  def amount_total_cart
    self.shopping_cart_items.amount_total_cart_item
  end

end
