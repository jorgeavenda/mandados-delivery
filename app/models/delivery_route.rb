class DeliveryRoute < ActiveRecord::Base
  belongs_to :urbanization
  belongs_to :residential
  belongs_to :building
  belongs_to :zone
  belongs_to :office
  has_many :domicile
  accepts_nested_attributes_for :domicile, :allow_destroy => true

  def get_addres_full
    "#{self.addres} #{"Urb. "+self.urbanization.name unless self.urbanization.nil?} #{"Resd. "+self.residential.name unless self.residential.nil?} #{"Edif. "+self.building.name unless self.building.nil?}"
  end

  def get_addres_time_full
    "#{self.addres} #{"Urb. "+self.urbanization.name unless self.urbanization.nil?} #{"Resd. "+self.residential.name unless self.residential.nil?} #{"Edif. "+self.building.name unless self.building.nil?} - #{self.delivery_time}"
  end

end
