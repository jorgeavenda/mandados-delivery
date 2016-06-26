class Domicile < ActiveRecord::Base
  belongs_to :buyer
  belongs_to :delivery_route
end
