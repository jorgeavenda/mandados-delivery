class BuyerInfo < ActiveRecord::Base
  belongs_to :buyer
  accepts_nested_attributes_for :buyer, allow_destroy: true

end
