class Zone < ActiveRecord::Base
  has_many :delivery_route
  has_many :delivery_time
  belongs_to :city
  accepts_nested_attributes_for :delivery_time, :allow_destroy => true

  def get_zone_full
    unless self.nil?
      "#{self.city.name.capitalize} - #{self.name.capitalize}"
    end
  end

end
