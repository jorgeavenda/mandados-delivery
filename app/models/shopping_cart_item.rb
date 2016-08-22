class ShoppingCartItem < ActiveRecord::Base
  belongs_to :shopping_cart
  belongs_to :product

  def self.amount_total_cart_item
    sum("quantity * amount")
  end

  def self.cost_total_cart_item
    sum("quantity * cost")
  end

  def update_dispatched(item_params)
    quantity = item_params[:quantity]
    self.update_attributes(dispatched: quantity)
  end
  
end
