class Buyer < User
  has_one :buyer_info
  accepts_nested_attributes_for :buyer_info

end
