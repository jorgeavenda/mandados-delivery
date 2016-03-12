class Buyer < User
  has_one :buyer_info
  accepts_nested_attributes_for :buyer_info

  def name
    self.buyer_info ? self.buyer_info.first_name : self.email
  end

  def fullname
    self.buyer_info ? self.buyer_info.fullname : self.name
  end

end
