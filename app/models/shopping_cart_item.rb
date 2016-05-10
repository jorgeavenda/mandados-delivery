class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :product

  def self.amount_total_cart_item
    sum("quantity * amount")
  end

end
