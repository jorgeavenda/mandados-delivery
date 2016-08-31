class Buyer < User
  has_one :buyer_info
  accepts_nested_attributes_for :buyer_info
  has_one :domicile
  accepts_nested_attributes_for :domicile

  has_many :shopping_carts

  def name
    self.buyer_info ? self.buyer_info.first_name : self.email
  end

  def fullname
    self.buyer_info ? self.buyer_info.fullname : self.name
  end

  def get_shopping_cart
    self.shopping_carts.last.blank? ? self.shopping_carts.create :
    self.shopping_carts.last.status_cart == StatusCart::INICIADO ? self.shopping_carts.last :  self.shopping_carts.create
  end

  def get_shopping_cart_prepared
    self.shopping_carts.where(status_cart: StatusCart::PREPARADO)
  end

  def activate
    self.update_attributes(active: true)
  end

end
