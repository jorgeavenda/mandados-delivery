class Domicile < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :delivery_route
  validates :delivery_route, presence: { message: "Seleccione una ruta de entrega" }
  validates :home, presence: { message: "Especifique nro. de casa o apartamento" }
end
