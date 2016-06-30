class ShoppingCart < ActiveRecord::Base
  belongs_to :buyer

  has_many :shopping_cart_items
  has_many :products, through: :shopping_cart_items


  def remove_item(shopping_cart_item)
    self.shopping_cart_items.destroy(shopping_cart_item)
    update_product_stock(shopping_cart_item, 'increase')
  end

  def amount_total_cart
    self.shopping_cart_items.amount_total_cart_item
  end

  def add_item(item_params)
    product_id = item_params[:product_id]
    if Product.find_by_id(product_id).measuring_type == MeasuringType::UNIDAD
      item_params[:quantity] = item_params[:quantity].to_f.round
    end
    quantity = item_params[:quantity]
    if Product.find_by_id(product_id).product_available?(quantity)
      self.shopping_cart_items.create(item_params)
      update_product_stock(item_params, 'decrease')
    else
      return false
    end
  end

  def update_product_stock(item_params, action)
    product_id = item_params[:product_id]
    quantity = item_params[:quantity]
    Product.find_by_id(product_id).update_stock(quantity, action)
  end

  def change_status_received
    self.update_attributes(status_cart: StatusCart::RECIBIDO, received_at: Time.now)
  end

  def change_status_prepared
    self.update_attributes(status_cart: StatusCart::PREPARADO)
  end

end
