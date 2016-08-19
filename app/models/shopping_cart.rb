class ShoppingCart < ActiveRecord::Base
  belongs_to :buyer

  has_many :shopping_cart_items
  has_many :packings
  accepts_nested_attributes_for :packings, :allow_destroy => true
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
      item_params[:quantity] = item_params[:quantity].to_f.ceil
    end
    quantity = item_params[:quantity]
    if Product.find_by_id(product_id).product_available?(quantity)
      self.shopping_cart_items.create(item_params)
      update_product_stock(item_params, 'decrease')
    else
      return false, "availability"
    end
  end

  def validate_quantity(item_params)
    quantity = item_params[:quantity]
    product_id = item_params[:product_id]
    if Product.find_by_id(product_id).measuring_type == MeasuringType::PESO and quantity.to_f < ConfigSystem.last.min_quantity
      return false, "minimun"
    else
      add_item(item_params)
    end
  end

  def amount_minimum_shopping?
    self.amount_total_cart < ConfigSystem.last.min_total_cart
  end

  def update_product_stock(item_params, action)
    product_id = item_params[:product_id]
    quantity = item_params[:quantity]
    Product.find_by_id(product_id).update_stock(quantity, action)
  end

  def change_status_received
    self.update_attributes(status_cart: StatusCart::RECIBIDO, received_at: Time.now, delivery_price: ConfigSystem.last.delivery_price)
  end

  def change_status_prepared
    self.update_attributes(status_cart: StatusCart::PREPARADO)
  end

  def change_status_delivered
    self.update_attributes(status_cart: StatusCart::ENTREGADO)
  end

end
