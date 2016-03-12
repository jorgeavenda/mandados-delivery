class BuyerInfo < ActiveRecord::Base
  belongs_to :buyer
  accepts_nested_attributes_for :buyer, allow_destroy: true

  def fullname
    "#{self.first_name} #{self.last_name}"
  end

end
