class ProductImage < ActiveRecord::Base
  belongs_to :product
  mount_uploader :image, ImageUploader

  def default_image
    image.nil? ? "default-upload.png" : image_url
  end

end
