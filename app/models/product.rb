class Product < ActiveRecord::Base
  has_many :product_images
  accepts_nested_attributes_for :product_images, :allow_destroy => true

  has_many :shopping_cart_items
  has_many :shopping_carts, through: :shopping_cart_items

  scope :all_greater_stock,  -> { where("stock >= stock_min") }

  def first_image
    self.product_images.present? ? self.product_images.first_image : "default.png"
  end

  def self.show_by_stock
    all_greater_stock
  end

end
