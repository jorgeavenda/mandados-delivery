class BuyerInfo < ActiveRecord::Base
  belongs_to :buyer
  accepts_nested_attributes_for :buyer, allow_destroy: true
  validates :first_name, presence: { message: "Especifique nombre" }
  validates :last_name, presence: { message: "Especifique apellido" }
  validates :phonenumber, presence: { message: "Especifique teléfono" }
  validates :phonenumber, format: { with: /\d{4}-\d{7}/,
    message: "Especifique teléfono con este formato: 9999-9999999" }
  

  def fullname
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

end
