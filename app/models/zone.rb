class Zone < ActiveRecord::Base
  has_many :delivery_route
  belongs_to :city
end
