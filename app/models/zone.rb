class Zone < ActiveRecord::Base
  has_many :delivery_route
  belongs_to :city

  def get_zone_full
    unless self.nil?
      "#{self.city.name.capitalize} - #{self.name.capitalize}"
    end
  end

end
