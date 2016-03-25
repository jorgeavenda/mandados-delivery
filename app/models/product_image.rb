class ProductImage < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :product

  def self.first_image
    first.present? ? first.image_url : "default.png"
  end

end
