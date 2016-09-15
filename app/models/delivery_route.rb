class DeliveryRoute < ActiveRecord::Base
  belongs_to :urbanization
  belongs_to :residential
  belongs_to :building
  belongs_to :zone
  belongs_to :office
  has_many :domicile
  accepts_nested_attributes_for :domicile, :allow_destroy => true

  def get_addres_full
    unless self.other?
      "#{self.addres} #{"Urb. "+self.urbanization.name unless self.urbanization.nil?} #{"Resd. "+self.residential.name unless self.residential.nil?} #{"Edif. "+self.building.name unless self.building.nil?} #{"Ofic. "+self.office.name unless self.office.nil?}"
    else
       "#{self.addres}"
    end
  end

  def get_without_addres
    unless self.other?
      "#{"Urb. "+self.urbanization.name unless self.urbanization.nil?} #{"Resd. "+self.residential.name unless self.residential.nil?} #{"Edif. "+self.building.name unless self.building.nil?} #{"Ofic. "+self.office.name unless self.office.nil?}"
    else
       "#{self.addres}"
    end
  end

  def get_addres_time_full
    unless self.other?
      "#{self.addres} #{"Urb. "+self.urbanization.name unless self.urbanization.nil?} #{"Resd. "+self.residential.name unless self.residential.nil?} #{"Edif. "+self.building.name unless self.building.nil?} #{"Ofic. "+self.office.name unless self.office.nil?} - #{self.delivery_time}"
    else
      "#{self.addres} - #{self.delivery_time.in_time_zone('Caracas').strftime("%I:%M %p")}"
    end
  end

  def get_delivery_time
    self.delivery_time.in_time_zone('Caracas').strftime("%I:%M %p")
  end
end
